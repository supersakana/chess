# frozen_string_literal: true

require_relative 'piece_factory'

# contains king functionality
class King < Piece
  attr_accessor :icon
  attr_reader :color

  def initialize(color)
    super
    @icon = "\u265A"
    @color = color
  end
end
