# frozen_string_literal: true

# contains bishop functionality
class Bishop < Piece
  attr_reader :icon

  def initialize(position)
    super(position)
    @icon = "\u265D"
  end
end
