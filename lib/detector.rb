# frozen_string_literal: true

# contains method for detecting board status and validating inputs
module Detector
  # returns true if a given input is a legal move
  def legal?(key, player, board)
    board.player_pieces(player.color).any? do |start, _v|
      start == key[0] && legals(start, player, board).include?(key[1])
    end
  end

  # returns full list of legal moves given a piece position
  def legals(start, player, board)
    possibles(start, board).reject { |land| checks_self?([start, land], player, board) }
  end

  # returns list of possible moves (excludes moves that check self)
  def possibles(start, board, moves = [])
    board.on(start).piece_shifts(board).each do |shift|
      moves << board.on(start).piece.iterate(shift, start, board)
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
    pieces.any? do |start, _v|
      possibles(start, board).any? { |move| board.on(move).king? }
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
      legals(start, player, board).empty?
    end
  end
end
