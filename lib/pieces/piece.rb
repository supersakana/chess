# frozen_string_literal: true

# superclass and factory for all pieces
class Piece
  attr_accessor :position
  attr_reader :color

  def initialize(position)
    @position = position
    @color = create_color(position)
    @vaccant_moves = []
  end

  # returns a piece color
  def create_color(position)
    position[0] < 2 ? :light_white : :black
  end

  # generates a list of coordinates
  def possible_moves
    raise NotImpelementedError
  end

  # creates a piece based on initial position
  def self.call(position)
    if starts[:rook].include?(position)
      Rook.new(position)
    elsif starts[:bishop].include?(position)
      Bishop.new(position)
    elsif starts[:knight].include?(position)
      Knight.new(position)
    elsif starts[:king].include?(position)
      King.new(position)
    elsif starts[:queen].include?(position)
      Queen.new(position)
    elsif [1, 6].include?(position[0])
      Pawn.new(position)
    end
  end

  # starting positions for each piece
  def self.starts
    {
      rook: [[0, 0], [7, 0], [0, 7], [7, 7]],
      bishop: [[0, 2], [0, 5], [7, 2], [7, 5]],
      knight: [[0, 1], [0, 6], [7, 1], [7, 6]],
      king: [[0, 4], [7, 4]],
      queen: [[0, 3], [7, 3]]
    }
  end
end
