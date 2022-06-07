# frozen_string_literal: true

# contains all display messages for game (puts/gets)
module Display
  # prompt for player to choose game type
  def display_games
    puts 'Select game type...'
    puts '[1] Human vs CPU'
    puts '[2] Human vs Human'
    gets.chomp
  end

  # prompt for player to make a move
  def display_choice(player)
    puts "#{player}... make your move (i.e. a2a3)"
  end

  # anytime an invalid input is passed
  def display_invalid
    puts 'Invalid Input'.colorize(color: :red)
  end

  # name prompt for when a player is created
  def display_name(number, team)
    puts "Player #{number}, your team is #{team}."
    puts 'What is your name?'
    gets.chomp
  end
end
