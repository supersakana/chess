# frozen_string_literal: true

require 'pry-byebug'

# contains methods that determine an en passant
class EnPassant
  # becomes enabled if en passant is detected, disabled if not immidiatly executed
  def initialize
    @enabled = false
  end

  # returns true if the user can make an en passant move
  def true?(start, board)
    left_cell = board.cells[[start[0] - 1, start[1]]]
    right_cell = board.cells[[start[0] + 1, start[1]]]

    # color is white and on 5th rank
    @color == :light_white &&
      start[1] == 4 &&

      # left or right cell is a pawn of opposing color
      (left_cell.piece.is_a?(Pawn) && color == :black) || (right_cell.piece.is_a?(Pawn) && color == :black) &&

        # en passant is enabled
        @enabled == true &&

        # the opponet pawn jumped
        (left_cell.piece.jumped || right_cell.piece.jumped)
  end
end
