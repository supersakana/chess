# frozen_string_literal: true

require 'pry-byebug'

# contains method for detecting the board's status
class Detector
  # checks if a given input is valid
  def valid?(input, translated, player, board)
    return false unless input.length == 4

    legal?(translated, player, board) && checks_self?(translated, player, board) == false
  end

  # returns true if a given input is a legal move
  def legal?(translated, player, board)
    board.player_pieces(player.color).any? do |start, _v|
      start == translated[0] && legal_moves(start, player, board).include?(translated[1])
    end
  end

  # returns full list of legal moves given a piece position
  def legal_moves(start, player, board)
    possible_moves(start, board).reject { |land| checks_self?([start, land], player, board) }
  end

  # returns list of possible moves (excludes moves that check self)
  def possible_moves(start, board, moves = [])
    board.cells[start].piece_transitions.each do |shift|
      moves << board.cells[start].piece.iterate(shift, start, board)
    end
    moves.flatten(1).uniq
  end

  # returns true if a translated move checks itself
  def checks_self?(translated, player, board)
    board_copy = Marshal.load(Marshal.dump(board))
    board_copy.move_piece(translated)

    check?(player, board_copy)
  end

  # returns true if a king is in check position
  def check?(player, board)
    pieces = board.player_pieces(player.foe_color)
    pieces.any? do |k, _v|
      possible_moves(k, board).any? { |move| board.cells[move].piece.is_a?(King) }
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
end
