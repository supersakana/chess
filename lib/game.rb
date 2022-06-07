# frozen_string_literal: true

require 'pry-byebug'

# contains player functionality
class Game

  include Display

  def initialize
    @board = Board.new
    @player_one = nil
    @player_two = nil
    @round = 0
  end

  # general functionality between start to end of game
  def start
    game_choice
    @board.print_board
  end

  # prompts user
  def game_choice
    choice = display_games
    puts "you choose #{choice}"
  end
end
