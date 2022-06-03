# frozen_string_literal: true

# contains rook functionality
class Rook < Piece
  attr_reader :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265C"
  end

  # generates a list of coordinates
  def possible_moves
    [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
     [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]]
  end
end
