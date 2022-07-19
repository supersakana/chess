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
    (value[0] + value[1]).odd? ? :white : :light_black
  end

  # true if cell piece is nil
  def empty?
    @piece.nil?
  end

  # true if cell contains a piece
  def occupied?
    !empty?
  end

  # returns the color of piece
  def piece_color
    return @piece.color unless empty?
  end

  # returns foe color of piece
  def foe_color
    return if empty?

    piece_color == :light_white ? :black : :light_white
  end

  # returns true if the cells piece has an en passant avalible
  def ep_enabled?
    return unless pawn?

    @piece.ep_enabled == true
  end

  # disables a pawns en passant
  def disable_ep
    @piece.ep_enabled = nil if pawn?
    @piece.jumped = nil
  end

  # returns piece transitions
  def piece_shifts
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

  # returns true if piece is a pawn
  def pawn?
    @piece.is_a?(Pawn)
  end

  # returns true if piece is a king
  def king?
    @piece.is_a?(King)
  end

  # returns true if piece is a knight
  def knight?
    @piece.is_a?(Knight)
  end

  # returns true if piece is a bishop
  def bishop?
    @piece.is_a?(Bishop)
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
