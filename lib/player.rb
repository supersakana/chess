# frozen_string_literal: true

# contains player functionality
class Player
  include Display

  attr_accessor :pieces
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end
end
