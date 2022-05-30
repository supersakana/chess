# frozen_string_literal: true

# contains knight functionality
class Knight
  attr_accessor :icon
  attr_reader :color

  def initialize(color)
    @icon = "\u265E"
    @color = color
  end
end
