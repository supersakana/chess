# frozen_string_literal: true

require_relative 'cell'
# contains game board functionality
class Board
  def initialize
    @cells = {}
  end

  # creates 64 coordinates (8 x 8 grid)
  def create_board
    coordinates = (0..7).to_a
    coordinates.each do |x|
      coordinates.each do |y|
        cell = Cell.new([x, y])
        add_cell(cell)
      end
    end
  end

  def add_cell(cell)
    @board[cell.value] = cell
  end
end
