# frozen_string_literal: true

require 'pry-byebug'

# contains game board functionality
class Board
  attr_accessor :cells

  def initialize
    @cells = create_board
  end

  # list of all the piece objects in each occupied cell
  def all_pieces(pieces = [])
    @cells.each do |_k, v|
      pieces << v.piece unless v.piece.nil?
    end
    pieces
  end

  # returns avalible moves for a given piece
  def vaccant_moves(piece, moves = [])
    i = assign_i(piece)
    @cells[piece].piece.transitions.each do |value|
      until i.zero?
        x = move[0] + value[0]
        y = move[1] + value[1]
        move = [x, y]
        break if @cells[move].piece.color == @cells[piece].piece.color

        moves << move if x.between?(0, 7) && y.between?(0, 7)
      end
    end
  end

  # assigns number of iterations based on given piece)
  def assign_i(move)
    if @cells[move].piece.instance_of?(Rook) ||
       @cells[move].piece.instance_of?(Bishop) ||
       @cells[move].piece.instance_of?(Queen)
      7
    else
      1
    end
  end

  # takes an input and returns [start, landing] positions (a2a3 => [[0, 1], [0, 2]])
  def translate(input)
    alpha = ('a'..'h').to_a
    start = [alpha.index(input[0]), input[1].to_i - 1]
    land = [alpha.index(input[2]), input[3].to_i - 1]
    [start, land]
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

  private

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
end
