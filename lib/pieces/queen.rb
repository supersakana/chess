# frozen_string_literal: true

# contains queen functionality
class Queen < Piece
  attr_reader :icon, :value

  def initialize(position)
    super
    @color = create_color(position)
    @icon = "\u265B"
    @value = 9
  end

  # list of increments needed to find possible queen moves
  def transitions
    [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
  end

  # assigns number of iterations based on given piece
  def iterator
    7
  end
end
