# frozen_string_literal: true

# ruby lib/main.rb

require_relative 'library'

puts <<~HEREDOC
  Welcome Chess!

  Instructions will go here.

  (Click ENTER to start!)

HEREDOC
gets

def create_player
  
end

game = Game.new
game.start
