# frozen_string_literal: true

# contains king functionality
class King < Piece
  attr_accessor :icon
  attr_reader :color

  def initialize(color)
    super(color)
    @icon = "\u265A"
  end
end
