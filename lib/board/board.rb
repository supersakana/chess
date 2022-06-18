# frozen_string_literal: true

require 'pry-byebug'

# contains game board functionality
class Board
  attr_accessor :cells

  def initialize
    @cells = create_board
  end

  # checks if a given move is valid
  # def valid?(move, _color)
  #   return false unless move.length == 4
  # end

  # returns a list of a player's pieces given the player color
  def player_pieces(color, pieces = [])
    @cells.each do |_k, v|
      pieces << v.piece unless v.empty?
    end
    pieces.select { |piece| piece.color == color }
  end

  # takes move and returns [start, landing] positions (a2a3 => [[0, 1], [0, 2]])
  def translate(move)
    alpha = ('a'..'h').to_a
    start = [alpha.index(move[0]), move[1].to_i - 1]
    land = [alpha.index(move[2]), move[3].to_i - 1]
    [start, land]
  end

  # returns legal moves given piece position (excludes pawns)
  def legals(position, moves = [])
    @cells[position].piece_transitions.each do |transition|
      moves << if @cells[position].piece.is_a?(Pawn)
                 iterate_pawn(transition, position)
               else
                 iterate_position(transition, position)
               end
    end
    moves.flatten(1).uniq
  end

  # returns line of legal moves given pawn transitions
  def iterate_pawn(transition, position)
    move = create_move(position, transition)
    if pawn_vertical?(move, transition) || (pawn_diagonal?(transition) && opposing_team?(move, position))
      [move]
    else
      []
    end
  end

  # returns true if pawn move has a verticle opening
  def pawn_vertical?(move, transition)
    @cells[move].empty? && transition.include?(0)
  end

  # returns true if pawn transition is diagonal
  def pawn_diagonal?(transition)
    [[1, 1], [-1, 1], [1, -1], [-1, -1]].include?(transition)
  end

  # (TEST THIS) returns line of legal moves given a piece's transition (excludes pawns)
  # rubocop:disable Metrics/MethodLength
  def iterate_position(transition, position, move = position, line = [])
    i = iterators(position)
    i.times do
      move = create_move(move, transition)
      if @cells[move].empty?
        line << move
      elsif opposing_team?(move, position)
        line << move
        break
      else
        break
      end
    end
    line
  end
  # rubocop:enable Metrics/MethodLength

  # (TEST THIS) returns a possible move given a transition
  def create_move(move, transition)
    x = move[0] + transition[0]
    y = move[1] + transition[1]
    return move unless x.between?(0, 7) && y.between?(0, 7)

    [x, y]
  end

  # assigns number of iterations based on given piece
  def iterators(move)
    if @cells[move].piece.line_moves?
      7
    else
      1
    end
  end

  # returns true if capture color is different from initial piece color
  def opposing_team?(move, position)
    @cells[move].piece_color == @cells[position].foe_color
  end

  # prints the formatted board
  def print
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
