# frozen_string_literal: true

# contains pawn functionality
class Pawn < Piece
  attr_accessor :pawn_jump, :jumped
  attr_reader :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265F"
    @jump_enabled = true
    @jumped = false
    @en_passant = EnPassant.new
  end

  # list of increments needed to find possible pawn moves
  def transitions
    if @color == :light_white && @jump_enabled == true
      pawn_shifts[:white_jump]
    elsif @color == :light_white && @jump_enabled == false
      pawn_shifts[:white]
    elsif @color == :black && @jump_enabled == true
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

  # returns legal moves given pawn transitions
  def iterate(shift, start, board)
    @en_passant.enable if @en_passant.true?(start, board)

    move = create_move(shift, start)
    if (vertical_shift?(shift, move, board) && blocked_jump?(shift, move, board)) ||
       (diagonal_shift?(shift) && opposing_piece?(move, start, board)) ||
       @en_passant.open?(start, move, board)
      [move]
    else
      []
    end
  end

  # returns true if pawn move has a verticle opening
  def vertical_shift?(shift, move, board)
    board.cells[move].empty? && shift.include?(0)
  end

  # returns true if pawn transition is diagonal
  def diagonal_shift?(shift)
    [[1, 1], [-1, 1], [1, -1], [-1, -1]].include?(shift)
  end

  # checks if a user is blocking a pawn jump
  def blocked_jump?(shift, move, board)
    return true unless [2, -2].include?(shift[1])

    prev = if shift == [0, 2]
             [move[0], move[1] - 1]
           else
             [move[0], move[1] + 1]
           end
    board.cells[prev].empty?
  end
end
