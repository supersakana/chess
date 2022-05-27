# frozen_string_literal: true

# contains bishop functionality
class Bishop
  attr_accessor :icon
  attr_reader :color

  def initialize(color)
    @icon = "\u265D"
    @color = color
  end
end
