# frozen_string_literal: true

# contains knight functionality
class Knight < Piece
  attr_reader :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265E"
  end

  # generates a list of possible queen coordinates
  def possible_moves(moves = [])
    transitions.each do |move|
      x = @position[0] + move[0]
      y = @position[1] + move[1]
      moves << [x, y] if x.between?(0, 7) && y.between?(0, 7)
    end
    moves
  end

  private

  # list of increments needed to find possible knight moves
  def transitions
    [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
  end
end
