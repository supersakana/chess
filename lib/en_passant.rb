# frozen_string_literal: true

require 'pry-byebug'

# contains methods that determine an en passant
class EnPassant
  # becomes enabled if en passant is detected, disabled if not immidiatly executed
  def initialize
    @enabled = false
  end

  # returns true if the user is enabled to make an en passant move
  # def open?(start, board)
  #   true?(start, board) && @enabled == true
  # end

  # # enables the en_passant to be open
  # def enable
  #   @enabled = true unless enable.nil?
  # end

  # returns true if en passant conditions are met
  def true?(start, board)
    selected = board.cells[start]
    left = board.cells[[start[0] - 1, start[1]]]
    right = board.cells[[start[0] + 1, start[1]]]

    correct_row?(selected) &&
      (foe_jumped?(left, selected) || foe_jumped?(right, selected))
  end

  # returns true if pawn position is in correct row for ep
  def correct_row?(selected)
    correct_row = selected.piece_color == :light_white ? 4 : 3

    selected.value[1] == correct_row
  end

  # returns true if left/right foe pawns jumped
  def foe_jumped?(cell, selected)
    cell.piece.is_a?(Pawn) &&
      cell.piece_color == selected.foe_color &&
      cell.piece.jumped
  end
end
