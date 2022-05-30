# frozen_string_literal: true

# contains king functionality
class King < Piece
  attr_accessor :icon
  attr_reader :color

  def initialize(color)
    @icon = "\u265A"
    @color = color
  end
end
