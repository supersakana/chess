# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize, Style/EmptyCaseCondition, Metrics/MethodLength

# superclass and factory for all pieces
class Piece
  attr_accessor :moved
  attr_reader :color

  def initialize(key)
    @color = create_color(key)
    @moved = false
  end

  # creates a specific piece given initial position
  def self.create(key)
    case
    when starts[:rook].include?(key) then Rook.new(key)
    when starts[:bishop].include?(key) then Bishop.new(key)
    when starts[:knight].include?(key) then Knight.new(key)
    when starts[:king].include?(key) then King.new(key)
    when starts[:queen].include?(key) then Queen.new(key)
    when [1, 6].include?(key[1]) then Pawn.new(key)
    end
  end

  def self.starts
    { rook: [[0, 0], [7, 0], [0, 7], [7, 7]],
      bishop: [[2, 0], [5, 0], [2, 7], [5, 7]],
      knight: [[1, 0], [6, 0], [1, 7], [6, 7]],
      king: [[4, 0], [4, 7]],
      queen: [[3, 0], [3, 7]] }
  end

  # returns a piece color based on initial row position
  def create_color(key)
    if key[1] < 2
      :light_white
    else
      :black
    end
  end

  # returns line of possible moves given a piece's shift (excludes pawns)
  def iterate(shift, start, board, move = start, line = [])
    iterator.times do
      move = create_move(shift, move)
      if board.cells[move].empty?
        line << move
      elsif opposing_piece?(move, start, board)
        line << move
        break
      else
        break
      end
    end
    line
  end

  # returns a possible move given a transition
  def create_move(shift, start)
    x = start[0] + shift[0]
    y = start[1] + shift[1]
    return start unless x.between?(0, 7) && y.between?(0, 7)

    [x, y]
  end

  # returns true if capture color is different from initial piece color
  def opposing_piece?(move, start, board)
    board.cells[move].piece_color == board.cells[start].foe_color
  end

  def moved?
    @moved == true
  end

  # list of increments needed to find possible moves
  def transitions
    raise NotImpelementedError
  end

  # returns true if possible moves are liniar (false if single coordinates)
  def line_moves?
    raise NotImpelementedError
  end

  # assigns number of iterations based on given piece
  def iterator
    raise NotImpelementedError
  end
end
# rubocop:enable Metrics/AbcSize, Style/EmptyCaseCondition, Metrics/MethodLength
