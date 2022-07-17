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

  # returns a list of all cells that contains pieces
  def all_pieces
    @cells.reject { |_k, v| v.empty? }
  end

  # selects the start and landing piece position then transfers (removes pawn jump if piece is a pawn)
  def move_piece(translated)
    start = @cells[translated[0]]
    land = @cells[translated[1]]

    transfer(start, land)
    analyze_board(start, land)
  end

  # moves a piece from start to landing position, captures if land contains foe
  def transfer(start, land)
    capture(start, land) if !land.empty? || start.ep_enabled?
    land.piece = start.piece
    start.piece = nil
  end

  # returns a captured piece given a landing position
  def capture(start, land)
    land = ep_land(start, land) if start.ep_enabled?

    if land.piece_color == :light_white
      @grave[:player_two] << land.piece.icon
    else
      @grave[:player_one] << land.piece.icon
    end
    land.piece = nil
  end

  # converts a pawn to promo piece if pawn can promote
  def promote(land)
    return unless @cells[land].piece.promote?(land)

    promo = display_promotion
    validate_promo(land, promo)
  end

  # prints the formatted board
  def print
    system 'clear'
    display_board(self)
    display_grave(@grave) unless @grave.all? { |_k, v| v.empty? }
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

  # returns the foe piece to be captured during en passant
  def ep_land(start, land)
    shift = start.piece_color == :light_white ? -1 : 1
    @cells[[land.value[0], land.value[1] + shift]]
  end

  # checks if an en_passant needs to be disable, inspects pawn, etc... (wip)
  def analyze_board(start, land)
    pawns = player_pieces(land.piece_color).select { |_k, v| v.piece.is_a?(Pawn) }
    pawns.each { |_k, v| v.piece.ep_enabled = nil if v.piece.ep_enabled == true }
    land.piece.inspect_pawn(start, land, self) unless land.empty?
  end
end
