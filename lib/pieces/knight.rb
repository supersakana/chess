# frozen_string_literal: true

# contains knight functionality
class Knight < Piece
  attr_reader :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265E"
  end

  # list of increments needed to find possible knight moves
  def transitions
    [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
  end

  # returns true if possible moves are liniar (false if single coordinates)
  def line_moves?
    false
  end
end
