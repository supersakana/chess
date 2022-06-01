# frozen_string_literal: true

# contains queen functionality
class Queen < Piece
  attr_accessor :icon
  attr_reader :color

  def initialize(color)
    super(color)
    @icon = "\u265B"
  end
end
