# frozen_string_literal: true

# contains king functionality
class King < Piece
  attr_reader :icon

  include Castling

  def initialize(position)
    super
    @color = create_color(position)
    @icon = "\u265A"
  end

  # list of increments needed to find possible knight moves
  def transitions(board)
    if kingside?(self, board)
      king_shifts[:kingside]
    elsif queenside?(self, board)
      king_shifts[:queenside]
    else
      king_shifts[:default]
    end
  end

  def king_shifts
    { kingside: [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [2, 0]],
      queenside: [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [-2, 0]],
      default: [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]] }
  end

  # assigns number of iterations based on given piece
  def iterator
    1
  end
end
