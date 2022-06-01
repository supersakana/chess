# frozen_string_literal: true

# contains pawn functionality
class Pawn < Piece
  attr_accessor :icon
  attr_reader :color

  def initialize(color)
    super(color)
    @icon = "\u265F"
  end
end
