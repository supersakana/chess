# frozen_string_literal: true

# contains queen functionality
class Queen < Piece
  attr_reader :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265B"
  end

  # list of increments needed to find possible queen moves
  def transitions
    [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
  end
end
