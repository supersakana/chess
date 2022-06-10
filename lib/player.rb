# frozen_string_literal: true

# contains player functionality
class Player
  include Display

  attr_accessor :pieces
  attr_reader :name, :team


  def initialize(name, team)
    @name = name
    @team = team
    @pieces = []
  end

  # prompts player to input start/landing position of chess piece
  def input
    input = display_choice(@name)
    translate(input) if valid_input?(input)
  end

  # converts input for program to access chess board (a2a3 => [[0, 1], [0, 2]])
  def translate(input)
    alpha = ('a'..'h').to_a
    start = [alpha.index(input[0]), input[1].to_i - 1]
    land = [alpha.index(input[2]), input[3].to_i - 1]
    [start, land]
  end

  # returns true if the input is valid

  def valid_input?(input)
    return false unless input.length == 4

    values = %w[1 2 3 4 5 6 7 8 a b c d e f g h]
    input.split('').all? { |char| values.include?(char) }
  end
end
