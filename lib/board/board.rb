# frozen_string_literal: true

require 'pry-byebug'

# contains game board functionality
class Board
  attr_accessor :cells

  def initialize
    @cells = create_board
  end

  # returns a hash of 64 coordinates (8 x 8 grid)
  def create_board
    coordinates = [0, 1, 2, 3, 4, 5, 6, 7].repeated_permutation(2).to_a
    hash = {}
    coordinates.each do |value|
      cell = Cell.new(value)
      add_cells(cell, hash)
    end
    hash
  end

  # adds cell with data
  def add_cells(cell, hash)
    hash[cell.value] = cell
  end

  # list of all the piece objects in each occupied cell
  def all_pieces(pieces = [])
    @cells.each do |_k, v|
      pieces << v.piece unless v.piece.nil?
    end
    pieces
  end

  # (REFACTOR) update the board given a start and landing position
  def update_board(start, land)
    selected = @cells[start].piece
    @cells[start].piece = nil
    selected.position = land
    @cells[land].piece = selected
    print_board
  end

  # prints the formatted board
  def print_board
    i = 7
    puts "   #{('A'..'H').to_a.join('  ')}"
    until i.negative?
      row = []
      @cells.select { |k, v| row << v.form if k[1] == i }
      puts "#{i + 1} #{row.join('')} #{i + 1}"
      i -= 1
    end
    puts "   #{('A'..'H').to_a.join('  ')}"
  end

  # determines the winner
  def check_mate?
    # code to run
  end
end
