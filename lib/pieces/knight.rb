# frozen_string_literal: true

# contains knight functionality
class Knight < Piece
  attr_reader :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265E"
  end
end
