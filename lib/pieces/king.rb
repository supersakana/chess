# frozen_string_literal: true

# contains king functionality
class King < Piece
  attr_reader :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265A"
  end

  # list of increments needed to find possible knight moves
  def transitions
    [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
  end

  # returns true if possible moves are liniar (false if single coordinates)
  def line_moves?
    false
  end
end
