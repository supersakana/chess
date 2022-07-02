# frozen_string_literal: true

# contains method for checking the board status
class Detector
  # checks if a given input is valid
  def valid?(input, translated, player, board)
    return false unless input.length == 4

    if check?(player.foe_color, board)
      checks_self?(translated, player.foe_color, board) == false
    else
      board.player_pieces(player.color).any? do |k, _v|
        k == translated[0] && legals(k, player.foe_color, board).include?(translated[1])
      end
    end
  end

  # returns full list of legal moves given a piece position
  def legals(start, color, board)
    possible_moves(start, board).reject { |land| checks_self?([start, land], color, board) }
  end

  # returns list of possible moves (excludes moves that check self)
  def possible_moves(start, board, moves = [])
    board.cells[start].piece_transitions.each do |shift|
      moves << board.cells[start].piece.iterate(shift, start, board)
    end
    moves.flatten(1).uniq
  end

  # returns true if a king is in check position
  def check?(color, board)
    pieces = board.player_pieces(color)
    pieces.any? do |k, _v|
      possible_moves(k, board).any? { |move| board.cells[move].piece.is_a?(King) }
    end
  end

  # returns true if a translated move checks itself
  def checks_self?(translated, color, board)
    board_copy = Marshal.load(Marshal.dump(board))
    board_copy.move_piece(translated)

    check?(color, board_copy)
  end

  # returns true if the user does not have any moves to uncheck itself
  def checkmate?(player, board)
    pieces = board.player_pieces(player.color)
    pieces.all? do |start, _v|
      possible_moves(start, board).all? { |land| checks_self?([start, land], player.foe_color, board) }
    end
  end

  # returns true if one side has no legal moves to make.
  def stalemate?(player, board)
    pieces = board.player_pieces(player.color)
    pieces.all? { |start, _v| legals(start, player.foe_color, board) == [] }
  end
end
