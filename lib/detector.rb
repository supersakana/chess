# frozen_string_literal: true

# contains method for detecting board status and validating inputs
class Detector
  # checks if a given input is valid
  def valid?(key, player, board)
    legal?(key, player, board) && !checks_self?(key, player, board)
  end

  # returns true if a given input is a legal move
  def legal?(key, player, board)
    board.player_pieces(player.color).any? do |start, _v|
      start == key[0] && legal_moves(start, player, board).include?(key[1])
    end
  end

  # returns full list of legal moves given a piece position
  def legal_moves(start, player, board)
    possible_moves(start, board).reject { |land| checks_self?([start, land], player, board) }
  end

  # returns list of possible moves (excludes moves that check self)
  def possible_moves(start, board, moves = [])
    board.cells[start].piece_shifts.each do |shift|
      moves << board.cells[start].piece.iterate(shift, start, board)
    end
    moves.flatten(1).uniq
  end

  # returns true if a translated move checks itself
  def checks_self?(key, player, board)
    board_copy = Marshal.load(Marshal.dump(board))
    board_copy.move_piece(key)

    check?(player, board_copy)
  end

  # returns true if a king is in check position
  def check?(player, board)
    pieces = board.player_pieces(player.foe_color)
    pieces.any? do |k, _v|
      possible_moves(k, board).any? { |move| board.cells[move].king? }
    end
  end

  # returns true if the user does not have any moves to uncheck itself
  def checkmate?(player, board)
    stalemate?(player, board) && check?(player, board)
  end

  # returns true if one side has no legal moves to make.
  def stalemate?(player, board)
    pieces = board.player_pieces(player.color)
    pieces.all? do |start, _v|
      legal_moves(start, player, board).empty?
    end
  end

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
