# frozen_string_literal: true

# contains information for each cell on the gameboard
class Cell
  attr_accessor :value, :piece

  def initialize(value)
    @value = value
    @piece = nil
  end
end
