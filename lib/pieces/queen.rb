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

  def transitions
    [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
  end
end
