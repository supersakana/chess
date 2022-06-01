# frozen_string_literal: true

# contains knight functionality
class Knight < Piece
  attr_accessor :icon
  attr_reader :color

  def initialize(color)
    super(color)
    @icon = "\u265E"
  end
end
