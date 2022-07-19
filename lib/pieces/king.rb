# frozen_string_literal: true

# contains king functionality
class King < Piece
  attr_reader :icon

  def initialize(position)
    super
    @color = create_color(position)
    @icon = "\u265A"
  end

  # list of increments needed to find possible knight moves
  def transitions
    [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
  end

  # assigns number of iterations based on given piece
  def iterator
    1
  end
end
