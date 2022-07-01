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

  # returns the foe's color
  def foe_color
    if @color == :light_white
      :black
    else
      :light_white
    end
  end
end
