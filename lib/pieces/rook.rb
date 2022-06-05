# frozen_string_literal: true

require 'pry-byebug'
# contains rook functionality
class Rook < Piece
  attr_reader :icon
  attr_accessor :position

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265C"
  end

  # generates a list of possible rook coordinates
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

  # list of increments needed to find possible rook moves
  def transitions
    [[0, 1], [1, 0], [0, -1], [-1, 0]]
  end
end
