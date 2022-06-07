# frozen_string_literal: true

# contains all display messages for game (puts/gets)
module Display
  # prompt for player to choose game type
  def display_games
    puts 'Select game type...'
    puts '[1] Human vs Human'
    puts '[2] Human vs Computer'
    gets.chomp
  end

  # prompt for player to make a move
  def display_choice(player)
    puts "#{player}... make your move (i.e. a2a3)"
  end
end
