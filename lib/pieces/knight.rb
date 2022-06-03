# frozen_string_literal: true

# contains knight functionality
class Knight < Piece
  attr_reader :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265E"
  end

  # generates a list of coordinates
  def possible_moves
    # code to run
  end
end
