# frozen_string_literal: true

# contains pawn functionality
class Pawn
  attr_accessor :icon
  attr_reader :color
  
  def initialize(color)
    @icon = "\u265F"
    @color = color
  end
end
