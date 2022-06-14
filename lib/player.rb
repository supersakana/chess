# frozen_string_literal: true

# contains player functionality
class Player
  include Display

  attr_accessor :pieces
  attr_reader :name, :team

  def initialize(name, color, pieces)
    @name = name
    @color = color
    @pieces = pieces
  end
end
