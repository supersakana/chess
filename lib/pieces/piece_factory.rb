# frozen_string_literal: true

require 'pry-byebug'

require_relative 'rook'
require_relative 'bishop'
require_relative 'knight'
require_relative 'king'
require_relative 'queen'
require_relative 'pawn'

# superclass for all pieces
class Piece
  # creates a piece based on initial position
  def call(position)
    color = set_color
    binding.pry
    case position
    when starts[:rook].include?(position)
      Rook.new(color)
    when starts[:bishop].include?(position)
      Bishop.new(color)
    when starts[:knight].include?(position)
      Knight.new(color)
    when starts[:king].include?(position)
      King.new(color)
    when starts[:queen].include?(position)
      Queen.new(color)
    end
  end

  # returns a piece color
  def set_color
    @value[0] < 2 ? :light_white : :black
  end

  # starting positions for each piece
  def starts
    {
      rook: [[0, 0], [0, 7], [7, 0], [7, 7]],
      bishop: [[0, 2], [0, 5], [7, 2], [7, 5]],
      knight: [[0, 1], [0, 6], [7, 1], [7, 6]],
      king: [[0, 4], [7, 4]],
      queen: [[0, 3], [7, 3]]
    }
  end
end
