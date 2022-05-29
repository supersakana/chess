# frozen_string_literal: true

require_relative 'piece_factory'

# contains knight functionality
class Knight < Piece
  attr_accessor :icon
  attr_reader :color

  def initialize(color)
    super
    @icon = "\u265E"
    @color = color
  end
end
