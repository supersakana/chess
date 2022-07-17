# frozen_string_literal: true

# superclass and factory for all pieces
class Piece
  attr_reader :color

  def initialize(position)
    @color = create_color(position)
  end

  # creates a piece based on initial position
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def self.call(position)
    if starts[:rook].include?(position)
      Rook.new(position)
    elsif starts[:bishop].include?(position)
      Bishop.new(position)
    elsif starts[:knight].include?(position)
      Knight.new(position)
    elsif starts[:king].include?(position)
      King.new(position)
    elsif starts[:queen].include?(position)
      Queen.new(position)
    elsif [1, 6].include?(position[1])
      Pawn.new(position)
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  # starting positions for each piece
  def self.starts
    {
      rook: [[0, 0], [7, 0], [0, 7], [7, 7]],
      bishop: [[2, 0], [5, 0], [2, 7], [5, 7]],
      knight: [[1, 0], [6, 0], [1, 7], [6, 7]],
      king: [[4, 0], [4, 7]],
      queen: [[3, 0], [3, 7]]
    }
  end

  # returns a piece color based on initial row position
  def create_color(position)
    if position[1] < 2
      :light_white
    else
      :black
    end
  end

  # returns line of legal moves given a piece's shift (excludes pawns)
  # rubocop:disable Metrics/MethodLength
  def iterate(shift, start, board, move = start, line = [])
    i = iterator
    i.times do
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
  # rubocop:enable Metrics/MethodLength

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

  # removes the pawn jump if pawn is moved from initial position and marks is a pawn made a jump or not
  def inspect_pawn(start, land, board)
    return unless is_a?(Pawn)

    jump = land.piece.color == :black ? -2 : 2

    # binding.pry if start.value == [3, 4]
    @ep_enabled = true if ep_true?(land.value, board)
    @jump_enabled = false if @jump_enabled == true
    @jumped = true if (start.value[1] + jump) == land.value[1]
  end

  # returns true if a pawn piece need promotion
  def promote?(position)
    return unless is_a?(Pawn)

    @color == :light_white && position[1] == 7 ||
      @color == :black && position[1].zero?
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
