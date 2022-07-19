# frozen_string_literal: true

# rubocop:disable Style/EmptyCaseCondition, Layout/MultilineOperationIndentation

# contains pawn functionality
class Pawn < Piece
  attr_accessor :pawn_jump, :jumped, :ep_enabled
  attr_reader :icon

  include EnPassant

  def initialize(position)
    super
    @color = create_color(position)
    @icon = "\u265F"
    @ep_enabled = false # ep = en passant
    @jump_enabled = true
    @jumped = false
  end

  # list of increments needed to find possible pawn moves
  def transitions
    case
    when @color == :light_white && @jump_enabled == true then pawn_shifts[:white_jump]
    when @color == :light_white && @jump_enabled == false then pawn_shifts[:white]
    when @color == :black && @jump_enabled == true then pawn_shifts[:black_jump]
    else
      pawn_shifts[:black]
    end
  end

  # list of pawn transitions
  def pawn_shifts
    { white: [[0, 1], [1, 1], [-1, 1]],
      white_jump: [[0, 1], [0, 2], [1, 1], [-1, 1]],
      black: [[0, -1], [1, -1], [-1, -1]],
      black_jump: [[0, -1], [0, -2], [1, -1], [-1, -1]] }
  end

  # returns legal moves given pawn transitions
  def iterate(shift, start, board)
    @ep_enabled = true if ep_true?(start, board)
    move = create_move(shift, start)
    if conditions_met?(shift, move, start, board)
      [move]
    else
      []
    end
  end

  # changes pawn status to @jump = true if pawn jump occured
  def pawn_jumped(start, land)
    jump = land.piece.color == :black ? -2 : 2
    @jumped = true if (start.value[1] + jump) == land.value[1]
  end

  # enables the ep when ep conditions are met
  def enable_ep(land, board)
    @ep_enabled = true if ep_true?(land.value, board)
  end

  # disables pawn jump if jump was made
  def disable_jump
    @jump_enabled = false if @jump_enabled == true
  end

  private

  # returns true if all pawn conditions are met
  def conditions_met?(shift, move, start, board)
    verti?(shift, move, board) ||
    diag?(shift, move, start, board) ||
    ep_open?(start, move, board, @ep_enabled)
  end

  # returns true if valid verticle move
  def verti?(shift, move, board)
    board.cells[move].empty? && shift.include?(0) && can_jump?(shift, move, board)
  end

  # returns true if valid diagonal move
  def diag?(shift, move, start, board)
    [[1, 1], [-1, 1], [1, -1], [-1, -1]].include?(shift) && opposing_piece?(move, start, board)
  end

  # checks if a user is blocking a pawn jump
  def can_jump?(shift, move, board)
    return true unless [2, -2].include?(shift[1])

    prev = shift == [0, 2] ? [move[0], move[1] - 1] : [move[0], move[1] + 1]
    board.cells[prev].empty?
  end
end
# rubocop:enable Style/EmptyCaseCondition, Layout/MultilineOperationIndentation
