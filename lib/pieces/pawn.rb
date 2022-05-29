# frozen_string_literal: true

require_relative 'piece_factory'

# contains pawn functionality
class Pawn < Piece
  attr_accessor :icon
  attr_reader :color

  def initialize(color)
    super
    @icon = "\u265F"
    @color = color
  end
end
