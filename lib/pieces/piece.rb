# frozen_string_literal: true

# superclass and factory for all pieces
class Piece
  def initialize(color)
    @color = color
  end

  # creates a piece based on initial position
  def self.call(value)
    color = create_color(value)
    if starts[:rook].include?(value)
      Rook.new(color)
    elsif starts[:bishop].include?(value)
      Bishop.new(color)
    elsif starts[:knight].include?(value)
      Knight.new(color)
    elsif starts[:king].include?(value)
      King.new(color)
    elsif starts[:queen].include?(value)
      Queen.new(color)
    elsif [1, 6].include?(value[0])
      Pawn.new(color)
    end
  end

  # returns a piece color
  def self.create_color(value)
    value[0] < 2 ? :light_white : :black
  end

  # starting positions for each piece
  def self.starts
    {
      rook: [[0, 0], [0, 7], [7, 0], [7, 7]],
      bishop: [[0, 2], [0, 5], [7, 2], [7, 5]],
      knight: [[0, 1], [0, 6], [7, 1], [7, 6]],
      king: [[0, 4], [7, 4]],
      queen: [[0, 3], [7, 3]]
    }
  end
end
