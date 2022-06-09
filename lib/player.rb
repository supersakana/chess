# frozen_string_literal: true

# contains player functionality
class Player
  include Display

  attr_reader :name, :team

  def initialize(name, team)
    @name = name
    @team = team
  end

  # prompts player to input start/landing position of chess piece
  def make_move
    choice = display_choice(@name)
    translate(choice) if valid_input?(choice)
  end

  # converts input for program to access chess board (a2a3 => [[0, 1], [0, 2]])
  def translate(choice)
    alpha = ('a'..'h').to_a
    start = [alpha.index(choice[0]), choice[1].to_i - 1]
    land = [alpha.index(choice[2]), choice[3].to_i - 1]
    [start, land]
  end

  # returns true if the input is valid
  # to be continued...
  def valid_input?(choice)
    return false unless choice.length == 4

    alpha = ('a'..'h').to_a
    numbers = (1..8)
    choice.split('').all? do |char|
      alpha.include?(char) || numbers.include?(char)
    end
  end
end
