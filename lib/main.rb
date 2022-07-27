# frozen_string_literal: true

# ruby lib/main.rb

require_relative 'library'

system 'clear'
puts <<~HEREDOC.colorize(color: :light_green)

  #{'                                                                                 '}
      ,o888888o.    8 8888        8 8 8888888888      d888888o.      d888888o.#{'   '}
     8888     `88.  8 8888        8 8 8888          .`8888:' `88.  .`8888:' `88.#{' '}
  ,8 8888       `8. 8 8888        8 8 8888          8.`8888.   Y8  8.`8888.   Y8#{' '}
  88 8888           8 8888        8 8 8888          `8.`8888.      `8.`8888.#{'     '}
  88 8888           8 8888        8 8 888888888888   `8.`8888.      `8.`8888.#{'    '}
  88 8888           8 8888        8 8 8888            `8.`8888.      `8.`8888.#{'   '}
  88 8888           8 8888888888888 8 8888             `8.`8888.      `8.`8888.#{'  '}
  `8 8888       .8' 8 8888        8 8 8888         8b   `8.`8888. 8b   `8.`8888.#{' '}
     8888     ,88'  8 8888        8 8 8888         `8b.  ;8.`8888 `8b.  ;8.`8888#{' '}
      `8888888P'    8 8888        8 8 888888888888  `Y8888P ,88P'  `Y8888P ,88P'#{' '}

   'Created by Zac Williamson'

HEREDOC
puts "Press 'ENTER' to play"
gets

# starts a new game
def play_game
  game = Game.new
  game.start
  replay
end

# prompts
def replay
  puts 'Would you like to play a new game?'
  puts "'y' -> yes 'n' -> no"
  choice = gets.chomp

  if choice == 'y'
    play_game
  else
    puts 'Thanks for playing!'
    exit
  end
end

play_game
