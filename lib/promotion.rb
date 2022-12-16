# frozen_string_literal: true

# rubocop:disable Layout/MultilineOperationIndentation

# contains methods that detect if a valid castling move is open
module Promotion
  include Display
  # converts a pawn to promo piece if pawn can promote
  def promote(board, land, promo = nil)
    pawn = board.on(land)
    return unless promote?(pawn)

    loop do
      promo = display_promotion
      break if %w[r b k q].include?(promo)
    end
    convert(pawn, promo)
  end

  # returns true if a pawn piece need promotion
  def promote?(pawn)
    return unless pawn.pawn?

    pawn.piece_color == :light_white && pawn.value[1] == 7 ||
    pawn.piece_color == :black && pawn.value[1].zero?
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
