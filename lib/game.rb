# frozen_string_literal: true

require 'pry-byebug'

# contains main game functionality
class Game
  include Display

  attr_accessor :round

  def initialize
    @board = Board.new
    @player_one = nil
    @player_two = nil
    @cpu = nil
    @round = 1
  end

  # general functionality between start to end of game
  def start
    game_choice
    game_loop
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

  # creates a new player object
  def create_player(number, team)
    name = display_name(number, team)
    Player.new(name, team)
  end

  # general gameplay until winner is declared
  def game_loop
    # until @board.check_mate?
    @board.print_board
    player = turn_player
    player.make_move
    # end
  end

  # switches current player
  def turn_player
    if round.odd?
      @player_one
    else
      @player_two
    end
  end

  private

  # sets up Human vs CPU
  def one_player
    puts 'Human vs CPU is not set up yet, work in progress...'
    exit
    # @player_one = create_player(1, 'White')
    # @cpu = nil # Cpu.new
  end

  # sets up Human vs Human
  def two_players
    @player_one = create_player(1, 'White')
    @player_two = create_player(2, 'Black')
  end
end
