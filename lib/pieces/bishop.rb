# frozen_string_literal: true

require_relative 'piece_factory'

# contains bishop functionality
class Bishop < Piece
  attr_accessor :icon
  attr_reader :color

  def initialize(color)
    super
    @icon = "\u265D"
    @color = color
  end
end
