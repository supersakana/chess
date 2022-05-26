# frozen_string_literal: true

require 'colorize'
require_relative 'cell'
# contains game board functionality
class Board
  attr_accessor :cells

  def initialize
    @cells = create_board
  end

  # creates 64 coordinates (8 x 8 grid)
  def create_board
    coordinates = (0..7).to_a
    cells = {}
    coordinates.each do |x|
      coordinates.each do |y|
        cell = Cell.new([x, y])
        cells[cell.value] = cell
      end
    end
    cells
  end
end

board = Board.new
board.cells.each do |k, v|
  p "#{k} => #{v.value}"
end
