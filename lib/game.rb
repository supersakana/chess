# frozen_string_literal: true

# rubocop:disable Layout/MultilineOperationIndentation

require 'pry-byebug'

# contains main game functionality
class Game
  include Display
  include Promotion
  include Helper
  include Detector

  attr_accessor :current

  def initialize
    @board = Board.new
    @player_one = nil
    @player_two = nil
    @current = nil
  end

  # general functionality between start to end of game
  def start
    if Dir.exist?('output')
      load_game
    else
      new_game
    end
  end

  def new_game
    two_players
    game_loop
  end

  # sets up Human vs Human
  def two_players
    @player_one = create_player(1, :light_white)
    @player_two = create_player(2, :black)
  end

  # general gameplay until checkmate is declared
  def game_loop
    loop do
      @current = turn_player
      @board.print
      break if game_over?(@board)

      display_check(@current) if check?(@current, @board)
      make_move
    end
    end_game
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
    key = key(input)
    validate(input, key)
  end

  # returns true if the game ends in a checkmate or stalemate
  def game_over?(board)
    checkmate?(@current, board) ||
    stalemate?(@current, board) ||
    insufficient_material?(board)
  end

  private

  # creates a new player object
  def create_player(number, color)
    name = display_name(number, color)
    Player.new(name, color)
  end

  # returns [start, landing] positions (a2a3 => [[0, 1], [0, 2]])
  def key(input)
    alpha = ('a'..'h').to_a
    start = [alpha.index(input[0]), input[1].to_i - 1]
    land = [alpha.index(input[2]), input[3].to_i - 1]
    [start, land]
  end

  # checks if move is valid then moves piece and promotes if neccissary
  def validate(input, key)
    if %w[e s d r].include?(input)
      helper(input, self)
    elsif legal?(key, @current, @board) && input.length == 4
      @board.move_piece(key)
      promote(@board, key[1])
    else
      make_move
    end
  end

  # declares the winner/draw of game
  def end_game(winner = turn_player)
    if checkmate?(@current, @board)
      display_checkmate(winner)
    elsif insufficient_material?(@board)
      display_insufficient
    else
      display_stalemate
    end
  end
end
# rubocop:enable Layout/MultilineOperationIndentation
