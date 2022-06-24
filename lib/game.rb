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
    @round = 1
  end

  # general functionality between start to end of game
  def start
    two_players
    game_loop
  end

  # sets up Human vs Human
  def two_players
    @player_one = create_player(1, :light_white)
    @player_two = create_player(2, :black)
  end

  # creates a new player object
  def create_player(number, color)
    name = display_name(number, color)
    Player.new(name, color)
  end

  # general gameplay until winner is declared
  def game_loop
    until @round == 100 # temporary
      @board.print
      make_move
    end
  end

  # player inputs move then move gets validated
  def make_move
    player = turn_player
    move = display_choice(player.name)
    validate(move, player.color)
  end

  # checks if move is valid
  def validate(move, color)
    if @board.valid?(move, color)
      @board.move_piece(move)
      @round += 1
    else
      make_move
    end
  end

  # switches current player
  def turn_player
    if @round.odd?
      @player_one
    else
      @player_two
    end
  end
end
