# frozen_string_literal: true

# contains pawn functionality
class Pawn < Piece
  attr_accessor :pawn_jump
  attr_reader :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265F"
    @pawn_jump = true
  end

  # list of increments needed to find possible pawn moves
  # Needs refactoring
  def transitions
    if @color == :light_white && @pawn_jump == true
      pawn_shifts[:white_jump]
    elsif @color == :light_white && @pawn_jump == false
      pawn_shifts[:white]
    elsif @color == :black && @pawn_jump == true
      pawn_shifts[:black_jump]
    else
      pawn_shifts[:black]
    end
  end

  # list of pawn transitions
  def pawn_shifts
    {
      white: [[0, 1], [1, 1], [-1, 1]],
      white_jump: [[0, 1], [0, 2], [1, 1], [-1, 1]],
      black: [[0, -1], [1, -1], [-1, -1]],
      black_jump: [[0, -1], [0, -2], [1, -1], [-1, -1]]
    }
  end

  # returns true if possible moves are liniar (false if single coordinates)
  def line_moves?
    false
  end

  # returns line of legal moves given pawn transitions
  def iterate(shift, start, board)
    move = create_move(shift, start)
    if pawn_vertical?(shift, move, board) || (pawn_diagonal?(shift) && opposing_team?(move, start, board))
      [move]
    else
      []
    end
  end

  # returns true if pawn move has a verticle opening
  def pawn_vertical?(shift, move, board)
    board.cells[move].empty? && shift.include?(0)
  end

  # returns true if pawn transition is diagonal
  def pawn_diagonal?(shift)
    [[1, 1], [-1, 1], [1, -1], [-1, -1]].include?(shift)
  end
end
