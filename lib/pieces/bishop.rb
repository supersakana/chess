# frozen_string_literal: true

# contains bishop functionality
class Bishop < Piece
  attr_reader :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265D"
  end

  # generates a list of possible bishop coordinates
  def possible_moves
    # code to run
  end

  private

  # list of increments needed to find possible rook moves
  def transitions
    # code to run
  end
end
