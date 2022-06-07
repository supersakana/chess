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

  # rubocop:disable Style/CaseLikeIf
  # prompts user
  def game_choice
    choice = display_games
    if choice == '1'
      one_player
    elsif choice == '2'
      two_players
    else
      display_invalid
      game_choice
    end
  end
  # rubocop:enable Style/CaseLikeIf

  def one_player
    @player_one = create_player
    @player_two = nil # Cpu.new
  end

  # sets up game for 2 humans
  def two_players
    @player_one = create_player
    @player_two = create_player
  end

  def create_player; end
end
