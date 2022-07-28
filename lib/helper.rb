# frozen_string_literal: true

require 'pry-byebug'

# contains methods that support the user given special inputs
module Helper
  include Data
  # supports user given an input
  def helper(input, game)
    if input == 'e'
      exit_game(game)
    else
      save_prompt(game)
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

  def save_prompt(game)
    choice = display_save
    save_game(game) if choice == 'y'

    game.make_move
  end

  # prompts user if they want to load an existing file
  def load_game
    system 'clear'
    show_files
    choice = display_load.to_i
    if choice.positive? && choice < Dir.entries('output').length - 1
      open_file(choice)
    else
      new_game
    end
  end
end
