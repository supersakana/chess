# frozen_string_literal: true

# contains king functionality
class King < Piece
  attr_reader :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265A"
  end

  # generates a list of coordinates
  def possible_moves
    # code to run
  end
end
