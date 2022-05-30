# frozen_string_literal: true

# contains player functionality
class Game
  def initialize
    @board = Board.new
  end

  def start
    @board.print_board
  end
end
