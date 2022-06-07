# frozen_string_literal: true

# contains pawn functionality
class Pawn < Piece
  attr_accessor :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265F"
  end

  # generates a list of possible pawn coordinates
  def possible_moves(moves = [])
    transitions.each do |move|
      x = @position[0] + move[0]
      y = @position[1] + move[1]
      moves << [x, y] if x.between?(0, 7) && y.between?(0, 7)
    end
    moves
  end

  private

  # list of increments needed to find possible pawn moves
  def transitions
    if @color == :light_white
      [[0, 1], [0, 2], [1, 1], [-1, 1]]
    else
      [[0, -1], [0, -2], [1, -1], [-1, -1]]
    end
  end
end
