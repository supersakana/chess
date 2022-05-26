# frozen_string_literal: true

# contains information for each cell on the gameboard
class Cell
  attr_accessor :piece
  attr_reader :value

  def initialize(value)
    @value = value
    @piece = nil
  end
end
