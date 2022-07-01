# frozen_string_literal: true

# contains method for checking the board status
class Detector
  # checks if a given input is valid
  def valid?(input, translated, player, board)
    return false unless input.length == 4

    if check?(player.foe_color, board)
      un_check?(translated, player.foe_color, board)
    else
      board.player_pieces(player.color).any? do |k, _v|
        k == translated[0] && legals(k, board).include?(translated[1])
      end
    end
  end

  # returns legal moves given piece start position
  # HOW CAN WE MAKE IT SO A PLAYER CAN NOT CHECK THEMSELVES
  def legals(start, board, moves = [])
    board.cells[start].piece_transitions.each do |shift|
      moves << board.cells[start].piece.iterate(shift, start, board)
    end
    moves.flatten(1).uniq # .reject { |land| checks_self?([start, land], board) }
  end

  # simulates a given move and returns true if board is not in check
  def un_check?(translated, color, board)
    board_copy = Marshal.load(Marshal.dump(board))
    board_copy.move_piece(translated)

    if check?(color, board_copy)
      false
    else
      true
    end
  end

  # returns true if a king is in check position
  def check?(color, board)
    pieces = board.player_pieces(color)
    pieces.any? do |k, _v|
      legals(k, board).any? { |move| board.cells[move].piece.is_a?(King) }
    end
  end

  # returns true if the user does not have any moves to uncheck itself
  def checkmate?(player, board)
    pieces = board.player_pieces(player.color)
    pieces.all? do |start, _v|
      legals(start, board).none? { |land| un_check?([start, land], player.foe_color, board) }
    end
  end

  # returns true if one side has no legal moves to make.
  # if the king is not in check, but no piece can be moved without checking itself => true
  def stalemate?(color, board)
    # pieces = board.player_pieces(color)
  end
end
