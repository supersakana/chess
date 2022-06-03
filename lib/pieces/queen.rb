# frozen_string_literal: true

# contains queen functionality
class Queen < Piece
  attr_reader :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265B"
  end

  # generates a list of coordinates
  def possible_moves
    # code to run
  end
end
