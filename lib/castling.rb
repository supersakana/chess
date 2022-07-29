# frozen_string_literal: true

# contains methods that detect if a valid castling move is open
module Castling
  include Detector
  # returns true if there is a king side castling open
  def kingside?(king, board)
    castling_true?(king, board) && vaccant?(king, board, [5, 6]) && moveless_rook?(7, king, board)
  end

  # returns true if there is a queen side castling open
  def queenside?(king, board)
    castling_true?(king, board) && vaccant?(king, board, [2, 3]) && moveless_rook?(0, king, board)
  end

  # returns true if conditions for castling are true
  def castling_true?(king, board)
    king.moved == false && not_check?(king, board)
  end

  # returns true if a given start, land position is a castling move
  def castling_move?(start, land)
    i = land.value[0] == 6 ? 2 : -2
    land.king? && start.value[0] + i == land.value[0]
  end

  # transfers a rook to correct position given a kings castling move
  def move_rook(board, land, x = land.value[0], y = land.value[1])
    i = x == 6 ? -2 : 3
    rook = x == 6 ? [7, y] : [0, y]
    rook_land = [rook[0] + i, rook[1]]
    board.move_piece([rook, rook_land])
  end

  private

  # returns true if queen/king side is vaccant for castling
  def vaccant?(king, board, shift)
    y = king.color == :black ? 7 : 0
    shift.all? do |x|
      board.on([x, y]).empty? && can_cross?([x, y], king, board)
    end
  end

  # returns true if cell in castling path will not be in check
  def can_cross?(cell, king, board)
    board_copy = Marshal.load(Marshal.dump(board))
    board_copy.on(cell).piece = king

    not_check?(king, board_copy)
  end

  # returns true if a king is not in check
  def not_check?(king, board)
    foe(king.color, board).all? do |start, _v|
      possibles(start, board).none? { |land| board.on(land).king? }
    end
  end

  # returns foe pieces given king piece color
  def foe(color, board)
    foe_color = color == :black ? :light_white : :black
    board.player_pieces(foe_color).reject { |_k, v| v.king? }
  end

  # returns true if either rook has not moved
  def moveless_rook?(x, king, board)
    y = king.color == :black ? 7 : 0
    return if board.on([x, y]).empty?

    board.on([x, y]).piece.moved == false
  end
end
