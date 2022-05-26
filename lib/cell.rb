# frozen_string_literal: true

# contains information for each cell on the gameboard
class Cell
  attr_accessor :piece
  attr_reader :value

  def initialize(value)
    @value = value
    @piece = nil
    @bg_color = create_bg
  end

  # returns a cell background color
  def create_bg
    (@value[0] + @value[1]).even? ? :white : :black
  end

  # returns the formatted cell
  def formatted
    if piece.nil?
      '   '.colorize(background: @bg_color)
    else
      @piece.colorize(background: @bg_color)
    end
  end
end
