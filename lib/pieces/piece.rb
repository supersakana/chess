# frozen_string_literal: true

# superclass and factory for all pieces
class Piece
  attr_reader :color

  def initialize(position)
    @color = create_color(position)
  end

  # creates a piece based on initial position
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
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
    elsif [1, 6].include?(position[1])
      Pawn.new(position)
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  # starting positions for each piece
  def self.starts
    {
      rook: [[0, 0], [7, 0], [0, 7], [7, 7]],
      bishop: [[2, 0], [5, 0], [2, 7], [5, 7]],
      knight: [[1, 0], [6, 0], [1, 7], [6, 7]],
      king: [[4, 0], [4, 7]],
      queen: [[3, 0], [3, 7]]
    }
  end

  # returns a piece color based on initial row position
  def create_color(position)
    if position[1] < 2
      :light_white
    else
      :black
    end
  end

  # list of increments needed to find possible moves
  def transitions
    raise NotImpelementedError
  end

  # returns true if possible moves are liniar (false if single coordinates)
  def line_moves?
    raise NotImpelementedError
  end
end
