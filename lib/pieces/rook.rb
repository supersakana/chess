# frozen_string_literal: true

# contains rook functionality
class Rook < Piece
  attr_reader :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265C"
  end
end
