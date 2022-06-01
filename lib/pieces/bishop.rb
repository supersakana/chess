# frozen_string_literal: true

# contains bishop functionality
class Bishop < Piece
  attr_accessor :icon
  attr_reader :color

  def initialize(color)
    super(color)
    @icon = "\u265D"
  end
end
