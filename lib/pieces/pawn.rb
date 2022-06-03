# frozen_string_literal: true

# contains pawn functionality
class Pawn < Piece
  attr_accessor :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265F"
  end

  # generates a list of coordinates
  def possible_moves
    # code to run
  end
end
