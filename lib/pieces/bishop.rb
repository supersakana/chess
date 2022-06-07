# frozen_string_literal: true

# contains bishop functionality
class Bishop < Piece
  attr_reader :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265D"
  end

  # generates a list of possible bishop coordinates
  def possible_moves(moves = [])
    transitions.each do |i|
      move = @position
      7.times do
        x = move[0] + i[0]
        y = move[1] + i[1]
        move = [x, y]
        moves << move if x.between?(0, 7) && y.between?(0, 7)
      end
    end
    moves
  end

  private

  # list of increments needed to find possible bishop moves
  def transitions
    [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  end
end
