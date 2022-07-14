# frozen_string_literal: true

# contains information for each cell on the gameboard
class Cell
  attr_accessor :piece
  attr_reader :value, :bg_color

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
    return @piece.color unless empty?
  end

  def foe_color
    return if empty?

    if piece_color == :light_white
      :black
    else
      :light_white
    end
  end

  # returns piece transitions
  def piece_transitions
    @piece.transitions unless empty?
  end

  # converts a piece from piece to promotion piece
  def convert(promo)
    color = @piece.color == :black ? [7, 7] : [0, 0]

    @piece = case promo
             when 'r' then Rook.new(color)
             when 'b' then Bishop.new(color)
             when 'k' then Knight.new(color)
             else
               Queen.new(color)
             end
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
