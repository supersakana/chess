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

  # returns a list of a player's cells/pieces given the player color
  def player_pieces(color)
    @cells.select { |_k, v| v.piece_color == color }
  end

  # selects the start and landing piece position then transfers (removes pawn jump if piece is a pawn)
  def move_piece(translated)
    start = @cells[translated[0]]
    land = @cells[translated[1]]

    transfer(start, land)
    land.piece.check_pawn unless land.empty?
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

  private

  # creates a 8x8 grid with coordinates (Hash of 64 values)
  def create_board(hash = {})
    coordinates = [0, 1, 2, 3, 4, 5, 6, 7].repeated_permutation(2).to_a
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
