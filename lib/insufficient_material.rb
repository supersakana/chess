# frozen_string_literal: true

# contains methods that detect if gameover by insufficient material
module InsufficientMaterial
  # returns true if there are no more effective pieces to declare checkmate
  def insufficient_material?(board)
    pieces = board.all_pieces.values
    kings_knights?(pieces) || kings_bishops?(pieces) || only_kings?(pieces)
  end

  private

  # returns true if the pieces are only kings and one knight
  def kings_knights?(pieces)
    pieces.all? { |piece| piece.king? || piece.knight? } &&
      pieces.one?(&:knight?)
  end

  # returns true if the pieces are only kings and bishops with same color square
  def kings_bishops?(pieces)
    bishops = pieces.select(&:bishop?)
    pieces.all? { |piece| piece.king? || piece.bishop? } &&
      bishops.map(&:bg_color).uniq.length == 1
  end

  # returns true if only pieces left are kings
  def only_kings?(pieces)
    pieces.all?(&:king?)
  end
end
