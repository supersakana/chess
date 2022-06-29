# frozen_string_literal: true

# contains method for checking the board status
class Detector
  # checks if a given input is valid
  def valid?(input, translated, color, board)
    return false unless input.length == 4

    if check?(board)
      un_check?(translated, board)
    else
      board.player_pieces(color).any? do |k, _v|
        k == translated[0] && legals(k, board).include?(translated[1])
      end
    end
  end

  # returns legal moves given piece start position
  def legals(start, board, moves = [])
    board.cells[start].piece_transitions.each do |shift|
      moves << board.cells[start].piece.iterate(shift, start, board)
    end
    moves.flatten(1).uniq
  end

  # simulates a given move and returns true if board is not in check
  def un_check?(translated, board)
    board_copy = Marshal.load(Marshal.dump(board))
    board_copy.move_piece(translated)

    if check?(board_copy)
      false
    else
      true
    end
  end

  # returns true if a king is in check position
  def check?(board)
    pieces = board.cells.reject { |_k, v| v.empty? }
    pieces.any? do |k, _v|
      legals(k, board).any? { |move| board.cells[move].piece.is_a?(King) }
    end
  end

  # returns true if the user does not have any moves to uncheck itself
  def checkmate?(color, board)
    # return unless check?(board)

    # pieces = board.player_pieces(color)
    # pieces.any? do |k, _v|
    #   legals(k, board).none? { |move| un_check?(move, board) }
    # end
  end
end
