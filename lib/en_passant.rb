# frozen_string_literal: true

require 'pry-byebug'

# contains methods that determine an en passant
class EnPassant
  # returns true if the user can make an en passant move
  def true?(start, board)
    left_cell = board.cells[[start[0] - 1, start[1]]]
    right_cell = board.cells[[start[0] + 1, start[1]]]

    @color == :light_white &&
      start[1] == 4 &&
      (left_cell.piece.is_a?(Pawn) && color == :black) || (right_cell.piece.is_a?(Pawn) && color == :black)
  end
end
