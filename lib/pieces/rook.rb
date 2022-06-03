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

  # generates a list of coordinates
  def possible_moves
    # moves = [@position]
    # transitions = [[0, 1], [1, 0], [0, -1], [-1, 0]]
    # code to run
  end
end
