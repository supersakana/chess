# frozen_string_literal: true

require 'pry-byebug'

# contains methods that support the user given special inputs
module Helper
  # supports user given an input esdr
  def consult(input, game)
    case input
    when 'e' then exit_game(game)
    when 's' # save_game
    when 'd' # draw
    else 'r'
      # resign
    end
  end

  # prompts user if they want to exit game
  def exit_game(game)
    choice = display_exit
    if choice == 'y'
      exit
    else
      game.make_move
    end
  end
end
