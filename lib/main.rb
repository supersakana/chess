# frozen_string_literal: true

# ruby lib/main.rb

require_relative 'library'

puts <<~HEREDOC
  Welcome Chess!

  Instructions will go here.

  (Click ENTER to start!)

HEREDOC
gets

game = Game.new
game.start
