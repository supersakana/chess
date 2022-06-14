# frozen_string_literal: true

# contains bishop functionality
class Bishop < Piece
  attr_reader :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265D"
  end

  # list of increments needed to find possible bishop moves
  def transitions
    [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  end
end
