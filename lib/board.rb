# frozen_string_literal: true

require 'pry-byebug'

# contains game board functionality(Will be disabled once Detector methods migrate)
class Board
  include Display
  include EnPassant

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
      @grave[:player_two] << land.piece.icon
    else
      @grave[:player_one] << land.piece.icon
    end
    land.piece = nil
  end

  # converts a pawn to promo piece if pawn can promote
  def promote(land)
    return unless @cells[land].promote?

    promo = display_promotion
    validate_promo(land, promo)
  end

  # prints the formatted board
  def print
    system 'clear'
    display_board(self)
    display_grave(@grave) unless @grave.values.all?(&:empty?)
  end

  private

  # converts pawn into inputted promo, else repromts user
  def validate_promo(land, promo)
    if %w[r b k q].include?(promo)
      @cells[land].convert(promo)
    else
      promote(land)
    end
  end

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

  # returns the foe piece to be captured during en passant
  def ep_land(start, land)
    shift = start.piece_color == :light_white ? -1 : 1
    @cells[[land.value[0], land.value[1] + shift]]
  end

  # checks updates status of moved pieces (pawns included)
  def inspect(start, land)
    player_pawns(land).each { |_k, v| v.disable_ep }
    land.inspect_pawn(start, land, self) unless land.empty?
    land.piece.moved = true
  end

  # returns list of player pawns given cell
  def player_pawns(cell)
    player_pieces(cell.piece_color).select { |_k, v| v.pawn? }
  end
end
