# frozen_string_literal: true

require 'pry-byebug'

require_relative 'pieces/rook'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/pawn'

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
  def start_positions
    {
      rook: [[0, 0], [0, 7], [7, 0], [7, 7]],
      bishop: [[0, 2], [0, 5], [7, 2], [7, 5]],
      knight: [[0, 1], [0, 6], [7, 1], [7, 6]],
      king: [[0, 4], [7, 4]],
      queen: [[0, 3], [7, 3]]
    }
  end

  # creates the correct piece for the correct position
  # temporary solution
  def create_piece(value)
    color = set_color
    @piece = if start_positions[:rook].include?(value)
               Rook.new(color)
             elsif start_positions[:bishop].include?(value)
               Bishop.new(color)
             elsif start_positions[:knight].include?(value)
               Knight.new(color)
             elsif start_positions[:king].include?(value)
               King.new(color)
             elsif start_positions[:queen].include?(value)
               Queen.new(color)
             elsif [1, 6].include?(value[0])
               Pawn.new(color)
             end
  end

  # returns a cell background color
  def set_bg
    (@value[0] + @value[1]).even? ? :white : :light_black
  end

  # returns a piece color
  def set_color
    @value[0] < 2 ? :light_white : :black
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
