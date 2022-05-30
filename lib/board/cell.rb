# frozen_string_literal: true

# contains information for each cell on the gameboard
class Cell
  attr_accessor :piece
  attr_reader :value

  def initialize(value)
    @value = value
    @piece = create_piece(value)
    @bg_color = set_bg
  end

  # creates the correct piece for the correct position
  # temporary solution
  def create_piece(value)
    color = value[0] < 2 ? :light_white : :black
    @piece = if starts[:rook].include?(value)
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

  # returns a cell background color
  def set_bg
    (@value[0] + @value[1]).even? ? :white : :light_black
  end

  # returns the formatted cell
  def formatted
    if piece.nil?
      '   '.colorize(background: @bg_color)
    else
      " #{@piece.icon} ".colorize(color: @piece.color, background: @bg_color)
    end
  end

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
