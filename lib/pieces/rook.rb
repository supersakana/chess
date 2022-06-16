# frozen_string_literal: true

# contains rook functionality
class Rook < Piece
  attr_reader :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265C"
  end

  # list of increments needed to find possible rook moves
  def transitions
    [[0, 1], [1, 0], [0, -1], [-1, 0]]
  end

  # returns true if possible moves are liniar (false if single coordinates)
  def line_moves?
    true
  end
end
