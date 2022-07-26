# frozen_string_literal: true

# contains bishop functionality
class Bishop < Piece
  attr_reader :icon, :value

  def initialize(position)
    super
    @color = create_color(position)
    @icon = "\u265D"
    @value = 3
  end

  # list of increments needed to find possible bishop moves
  def transitions
    [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  end

  # assigns number of iterations based on given piece
  def iterator
    7
  end
end
