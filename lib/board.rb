# frozen_string_literal: true

require 'pry-byebug'
require 'colorize'

require_relative 'cell'
# contains game board functionality
class Board
  attr_accessor :cells

  def initialize
    @cells = create_board
  end

  # returns a hash of 64 coordinates (8 x 8 grid)
  def create_board
    coordinates = (0..7).to_a
    hash = {}
    coordinates.each do |x|
      coordinates.each do |y|
        cell = Cell.new([x, y])
        add_cells(cell, hash)
      end
    end
    hash
  end

  # adds cell with data
  def add_cells(cell, hash)
    hash[cell.value] = cell
  end

  # prints the board in a basic format
  def print_board
    i = 7
    until i.negative?
      row = []
      @cells.select { |k, v| row << v.formatted if k[0] == i }
      puts "#{i + 1} #{row.join('')}"
      i -= 1
    end
    puts "   #{('A'..'H').to_a.join('  ')}"
  end
end

board = Board.new
board.print_board
