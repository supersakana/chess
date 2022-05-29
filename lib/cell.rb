# frozen_string_literal: true

require_relative 'pieces/piece_factory'

# contains information for each cell on the gameboard
class Cell
  attr_accessor :piece
  attr_reader :value

  def initialize(value)
    @value = value
    @piece = create_piece(value)
    @bg_color = set_bg
  end

  # initial positions for each piece

  # creates the correct piece for the correct position
  # temporary solution
  def create_piece(value)
    PieceFactory.call(value)
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
end
