# frozen_string_literal: true

# rubocop:disable Layout/MultilineOperationIndentation

require 'pry-byebug'

# contains methods that detect a valid en passant
module EnPassant
  # returns true if the user is enabled to make an en passant move
  def ep_open?(start, move, board, enabled)
    ep_true?(start, board) && ep_foe?(start, board, move) && enabled == true
  end

  # returns true if en passant conditions are met on either left or right side
  def ep_true?(start, board)
    user = board.on(start)
    left = board.on([start[0] - 1, start[1]])
    right = board.on([start[0] + 1, start[1]])

    ep_row?(user) && (foe_jumped?(left, user) || foe_jumped?(right, user))
  end

  # returns true if the move is an en passant
  def ep_move?(start, land)
    diag?(start, land) && start.pawn? && start.piece.ep_enabled == true
  end

  # returns the foe piece to be captured during en passant
  def ep_land(start, land)
    shift = start.piece_color == :light_white ? -1 : 1
    on([land.value[0], land.value[1] + shift])
  end

  private

  # returns true if en passant would capture foe
  def ep_foe?(start, board, move)
    user = board.cells[start]
    shift = user.piece_color == :black ? 1 : -1
    foe = board.on([move[0], move[1] + shift])

    foe.piece_color == user.foe_color
  end

  # returns true if move is diagonal
  def diag?(start, land, diag = [[1, 1], [1, -1], [-1, -1], [-1, 1]])
    diag.any? do |shift|
      x = start.value[0] + shift[0]
      y = start.value[1] + shift[1]
      land.value == [x, y]
    end
  end

  # returns true if pawn position is in correct row for ep
  def ep_row?(user)
    row = user.piece_color == :black ? 3 : 4
    user.value[1] == row
  end

  # returns true if left/right foe pawns jumped
  def foe_jumped?(cell, selected)
    return if cell.nil?

    cell.pawn? &&
    cell.piece_color == selected.foe_color &&
    cell.piece.jumped == true
  end
end
# rubocop:enable Layout/MultilineOperationIndentation
