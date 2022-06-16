# frozen_string_literal: true

# contains information for each cell on the gameboard
class Cell
  attr_accessor :piece
  attr_reader :value

  def initialize(value)
    @value = value
    @piece = create_piece(value)
    @bg_color = create_bg(value)
  end

  # creates the correct piece for the correct position
  def create_piece(value)
    @piece = Piece.call(value)
  end

  # returns a cell background color
  def create_bg(value)
    if (value[0] + value[1]).odd?
      :white
    else
      :light_black
    end
  end

  def empty?
    @piece.nil?
  end

  # returns the color of piece
  def piece_color
    @piece.color
  end

  # returns piece transitions
  def piece_transitions
    @piece.transitions
  end

  # returns the formatted cell
  def form
    if piece.nil?
      '   '.colorize(background: @bg_color)
    else
      " #{@piece.icon} ".colorize(color: @piece.color, background: @bg_color)
    end
  end
end
