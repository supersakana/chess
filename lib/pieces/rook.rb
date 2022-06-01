# frozen_string_literal: true

# require_relative 'piece'

# contains rook functionality
class Rook < Piece
  attr_accessor :icon
  attr_reader :color

  def initialize(color)
    super(color)
    @icon = "\u265C"
  end
end
