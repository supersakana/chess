# frozen_string_literal: true

require 'pry-byebug'

# contains game board functionality
class Board
  attr_accessor :cells

  def initialize
    @cells = create_board
  end

  # list of all the piece objects in each occupied cell (all pieces except pawns)
  def all_pieces(pieces = [])
    @cells.each do |_k, v|
      pieces << v.piece unless v.piece.nil?
    end
    pieces
  end

  # returns legal moves given piece position (excludes pawns)
  def legals(position, moves = [])
    @cells[position].piece_transitions.each do |transition|
      i = iterators(position)
      move = position
      i.times do
        move = create_move(move, transition)

        if @cells[move].empty?
          moves << move
        elsif @cells[move].piece_color != @cells[position].piece_color
          moves << move
          break
        else
          break
        end
      end
    end
    moves.uniq
  end

  # assigns number of iterations based on given piece)
  def iterators(move)
    if @cells[move].piece.line_moves?
      7
    else
      1
    end
  end

  # returns a possible move given a transition
  def create_move(move, transition)
    x = move[0] + transition[0]
    y = move[1] + transition[1]
    return move unless inbound?(x, y)

    [x, y]
  end

  # returns true if move position is within bounds of chess board
  def inbound?(x, y)
    x.between?(0, 7) && y.between?(0, 7)
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

  # creates a 8x8 grid with coordinates (Hash of 64 values)
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
