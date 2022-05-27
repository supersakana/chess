# frozen_string_literal: true

# contains rook functionality
class Rook
  attr_accessor :icon
  attr_reader :color

  def initialize(color)
    @icon = "\u265C"
    @color = color
  end
end
