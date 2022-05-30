# frozen_string_literal: true

# contains rook functionality
class Rook < Piece
  attr_accessor :icon
  attr_reader :color

  def initialize(color)
    super
    @icon = "\u265C"
    @color = color
  end
end
