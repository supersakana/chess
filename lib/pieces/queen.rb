# frozen_string_literal: true

# contains queen functionality
class Queen < Piece
  attr_reader :icon

  def initialize(position)
    super(position)
    @color = create_color(position)
    @icon = "\u265B"
  end
end
