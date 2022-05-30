# frozen_string_literal: true

# contains queen functionality
class Queen < Piece
  attr_accessor :icon
  attr_reader :color

  def initialize(color)
    @icon = "\u265B"
    @color = color
  end
end
