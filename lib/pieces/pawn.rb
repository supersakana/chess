# frozen_string_literal: true

# contains pawn functionality
class Pawn < Piece
  attr_accessor :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265F"
  end
  
  # list of increments needed to find possible pawn moves
  def transitions
    if @color == :light_white
      [[0, 1], [0, 2], [1, 1], [-1, 1]]
    else
      [[0, -1], [0, -2], [1, -1], [-1, -1]]
    end
  end
end
