# frozen_string_literal: true

# rubocop:disable Layout/MultilineOperationIndentation

require 'pry-byebug'

# contains methods that detect if a valid castling move is open
module Promotion
  include Display
  # converts a pawn to promo piece if pawn can promote
  def promote(board, land)
    return unless promote?(board, land)

    promo = display_promotion
    validate_promo(board, land, promo)
  end

  # returns true if a pawn piece need promotion
  def promote?(board, land)
    return unless board.cells[land].pawn?

    board.cells[land].piece_color == :light_white && board.cells[land].value[1] == 7 ||
    board.cells[land].piece_color == :black && board.cells[land].value[1].zero?
  end

  # converts pawn into inputted promo, else repromts user
  def validate_promo(board, land, promo)
    if %w[r b k q].include?(promo)
      convert(board, land, promo)
    else
      promote(land)
    end
  end

  # converts a piece from piece to promotion piece
  def convert(board, land, promo)
    color = board.cells[land].piece_color == :black ? [7, 7] : [0, 0]

    board.cells[land].piece = case promo
                              when 'r' then Rook.new(color)
                              when 'b' then Bishop.new(color)
                              when 'k' then Knight.new(color)
                              else
                                Queen.new(color)
                              end
  end
end
# rubocop:enable Layout/MultilineOperationIndentation
