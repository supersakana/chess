# frozen_string_literal: true

# rubocop:disable Layout/MultilineOperationIndentation

require 'pry-byebug'

# contains methods that detect if a valid castling move is open
module Promotion
  include Display
  # converts a pawn to promo piece if pawn can promote
  def promote(board, land)
    pawn = board.cells[land]
    return unless promote?(pawn)

    promo = display_promotion
    validate_promo(board, land, pawn, promo)
  end

  # returns true if a pawn piece need promotion
  def promote?(pawn)
    return unless pawn.pawn?

    pawn.piece_color == :light_white && pawn.value[1] == 7 ||
    pawn.piece_color == :black && pawn.value[1].zero?
  end

  # converts pawn into inputted promo, else repromts user
  def validate_promo(board, land, pawn, promo)
    if %w[r b k q].include?(promo)
      convert(pawn, promo)
    else
      promote(board, land)
    end
  end

  # converts a piece from piece to promotion piece
  def convert(pawn, promo)
    color = pawn.piece_color == :black ? [7, 7] : [0, 0]

    pawn.piece = case promo
                 when 'r' then Rook.new(color)
                 when 'b' then Bishop.new(color)
                 when 'k' then Knight.new(color)
                 else
                   Queen.new(color)
                 end
  end
end
# rubocop:enable Layout/MultilineOperationIndentation