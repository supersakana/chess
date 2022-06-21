# frozen_string_literal: true

require 'pry-byebug'

# contains game board functionality(Will be disabled once Detector methods migrate)
class Board
  include Display

  attr_reader :cells
  attr_accessor :grave

  def initialize
    @cells = create_board
    @grave = {
      player_one: [],
      player_two: []
    }
  end

  # checks if a given move is valid
  def valid?(input, color)
    return false unless input.length == 4

    translated = translate(input)

    player_pieces(color).any? do |k, _v|
      k == translated[0] && legals(k).include?(translated[1])
    end
  end

  # takes move and returns [start, landing] positions (a2a3 => [[0, 1], [0, 2]])
  def translate(input)
    alpha = ('a'..'h').to_a
    start = [alpha.index(input[0]), input[1].to_i - 1]
    land = [alpha.index(input[2]), input[3].to_i - 1]
    [start, land]
  end

  # returns a list of a player's cells/pieces given the player color
  def player_pieces(color)
    @cells.select { |_k, v| v.piece_color == color }
  end

  # returns legal moves given piece start position
  def legals(start, moves = [])
    @cells[start].piece_transitions.each do |shift|
      moves << @cells[start].piece.iterate(shift, start, self)
    end
    moves.flatten(1).uniq
  end

  # selects the start and landing piece position then transfers (removes pawn jump if piece is a pawn)
  def move_piece(input)
    translated = translate(input)
    start = @cells[translated[0]]
    land = @cells[translated[1]]

    transfer(start, land)
    land.piece.check_pawn
  end

  # moves a piece from start to landing position, captures if land contains foe
  def transfer(start, land)
    capture(land) unless land.empty?
    land.piece = start.piece
    start.piece = nil
  end

  # returns a captured piece given a landing position
  def capture(land)
    if land.piece_color == :light_white
      @grave[:player_two] << land.piece.icon
    else
      @grave[:player_one] << land.piece.icon
    end
  end

  # prints the formatted board
  def print
    system 'clear'
    display_board(self)
    display_grave(@grave) unless @grave.all? { |_k, v| v.empty? }
  end

  # returns true if a king is in check position
  def check?
    pieces = @cells.reject { |_k, v| v.empty? }
    pieces.any? do |k, _v|
      legals(k).any? { |move| @cells[move].piece.is_a?(King) }
    end
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
