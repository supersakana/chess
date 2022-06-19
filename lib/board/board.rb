# frozen_string_literal: true

require 'pry-byebug'

# contains game board functionality
class Board
  attr_accessor :cells

  def initialize
    @cells = create_board
  end

  # checks if a given move is valid
  def valid?(input, color)
    return false unless input.length == 4

    translated = translate(input)

    player_pieces(color).any? do |k, _v|
      k == translated[0] && legals(k).include?(translated[1])
    end
  end

  # returns a list of a player's cells/pieces given the player color
  def player_pieces(color)
    @cells.select { |_k, v| v.piece_color == color }
  end

  # takes move and returns [start, landing] positions (a2a3 => [[0, 1], [0, 2]])
  def translate(input)
    alpha = ('a'..'h').to_a
    start = [alpha.index(input[0]), input[1].to_i - 1]
    land = [alpha.index(input[2]), input[3].to_i - 1]
    [start, land]
  end

  # moves a piece from start to land position
  def move_piece(input)
    transfer = translate(input)
    start = transfer[0]
    land = transfer[1]
    p "#{start} => #{land}"
  end

  # returns legal moves given piece start position
  def legals(start, moves = [])
    @cells[start].piece_transitions.each do |shift|
      moves << if @cells[start].piece.is_a?(Pawn)
                 iterate_pawn(shift, start)
               else
                 iterate_piece(shift, start)
               end
    end
    moves.flatten(1).uniq
  end

  # returns line of legal moves given pawn transitions
  def iterate_pawn(shift, start)
    move = create_move(shift, start)
    if pawn_vertical?(shift, move) || (pawn_diagonal?(shift) && opposing_team?(move, start))
      [move]
    else
      []
    end
  end

  # returns true if pawn move has a verticle opening
  def pawn_vertical?(shift, move)
    @cells[move].empty? && shift.include?(0)
  end

  # returns true if pawn transition is diagonal
  def pawn_diagonal?(shift)
    [[1, 1], [-1, 1], [1, -1], [-1, -1]].include?(shift)
  end

  # returns line of legal moves given a piece's transition (excludes pawns)
  # rubocop:disable Metrics/MethodLength
  def iterate_piece(shift, start, move = start, line = [])
    i = iterators(start)
    i.times do
      move = create_move(shift, move)
      if @cells[move].empty?
        line << move
      elsif opposing_team?(move, start)
        line << move
        break
      else
        break
      end
    end
    line
  end
  # rubocop:enable Metrics/MethodLength

  # returns a possible move given a transition
  def create_move(shift, start)
    x = start[0] + shift[0]
    y = start[1] + shift[1]
    return start unless x.between?(0, 7) && y.between?(0, 7)

    [x, y]
  end

  # assigns number of iterations based on given piece
  def iterators(start)
    if @cells[start].piece.line_moves?
      7
    else
      1
    end
  end

  # returns true if capture color is different from initial piece color
  def opposing_team?(move, start)
    @cells[move].piece_color == @cells[start].foe_color
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
