# frozen_string_literal: true

require 'pry-byebug'

# contains main game functionality
class Game
  include Display

  attr_accessor :round

  def initialize
    @board = Board.new
    @detect = Detector.new
    @player_one = nil
    @player_two = nil
    @current = nil
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

  # general gameplay until checkmate is declared
  def game_loop
    loop do
      @current = turn_player
      @board.print
      break if game_over?(@current, @board)

      display_check(@current) if @detect.check?(@current, @board)
      make_move
    end
  end

  # switches current player
  def turn_player
    if @current == @player_one
      @player_two
    else
      @player_one
    end
  end

  # player inputs move then move gets validated
  def make_move
    input = display_choice(@current)
    translated = translate(input)
    validate(input, translated)
  end

  # takes move and returns [start, landing] positions (a2a3 => [[0, 1], [0, 2]])
  def translate(input)
    alpha = ('a'..'h').to_a
    start = [alpha.index(input[0]), input[1].to_i - 1]
    land = [alpha.index(input[2]), input[3].to_i - 1]
    [start, land]
  end

  # checks if move is valid
  def validate(input, translated)
    if @detect.valid?(input, translated, @current, @board)
      @board.move_piece(translated)
    else
      make_move
    end
  end

  # returns true if the game ends in a checkmate or stalemate
  def game_over?(player, board)
    @detect.checkmate?(player, board) || @detect.stalemate?(player, board)
  end
end
