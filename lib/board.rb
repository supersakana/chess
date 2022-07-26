# frozen_string_literal: true

require 'pry-byebug'

# contains game board functionality
class Board
  include Display
  include EnPassant
  include Castling

  attr_reader :cells
  attr_accessor :grave

  def initialize
    @cells = create_board
    @grave = {
      player_one: [],
      player_two: []
    }
  end

  # returns a list of a player cells given team color
  def player_pieces(color)
    @cells.select { |_k, cell| cell.piece_color == color }
  end

  # returns a list of all cells that contains pieces
  def all_pieces
    @cells.reject { |_k, cell| cell.empty? }
  end

  # selects the start and landing piece position then transfers
  def move_piece(key)
    start = @cells[key[0]]
    land = @cells[key[1]]

    transfer(start, land)
    inspect(start, land)
  end

  # moves piece from start to land position
  def transfer(start, land)
    capture(start, land) if land.occupied? || ep_move?(start, land) # ep = en passant
    land.piece = start.piece
    start.piece = nil
  end

  # returns a captured piece given a landing position
  def capture(start, land)
    land = ep_land(start, land) if ep_move?(start, land)

    if land.piece_color == :light_white
      @grave[:player_two] << land.piece
    else
      @grave[:player_one] << land.piece
    end
    land.piece = nil
  end

  # prints the formatted board
  def print
    system 'clear'
    display_board(self)
    display_grave(@grave) unless @grave.values.all?(&:empty?)
  end

  private

  # creates a 8x8 grid with coordinates (Hash of 64 values)
  def create_board(hash = {})
    key_values = [0, 1, 2, 3, 4, 5, 6, 7].repeated_permutation(2).to_a
    key_values.each do |xy|
      cell = Cell.new(xy)
      add_cells(cell, hash)
    end
    hash
  end

  # adds cell with data
  def add_cells(cell, hash)
    hash[cell.value] = cell
  end

  # checks updates status of moved pieces (pawns included)
  def inspect(start, land)
    player_pawns(land).each { |_k, v| v.disable_ep }
    land.inspect_pawn(start, land, self) unless land.empty?
    move_rook(self, land) if castling_move?(start, land)
    land.piece.moved = true
  end

  # returns list of player pawns given cell
  def player_pawns(cell)
    player_pieces(cell.piece_color).select { |_k, v| v.pawn? }
  end
end
