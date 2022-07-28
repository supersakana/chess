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
    puts "#{player.name}... make your move (i.e. a2a3)"
    gets.chomp.downcase
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

  # when a user is in check by opponent
  def display_check(player)
    puts "#{player.name} is in CHECK!".colorize(color: :yellow)
    puts 'Make a move to uncheck yourself'
  end

  # when a users pawn is ready to promote
  def display_promotion
    puts 'PROMOTION'
    puts 'Input a piece to promote into'
    puts "'r' -> Rook"
    puts "'b' -> Bishop"
    puts "'k' -> Knight"
    puts "'q' -> Queen"
    gets.chomp
  end

  def display_helper
    puts ''
    puts "'e' -> exit  's' -> save"
    puts ''
  end

  # when a checkmate is declared
  def display_checkmate(player)
    puts ''
    puts 'CHECKMATE'.colorize(color: :green)
    display_winner(player)
    puts ''
  end

  # when a winner is declared
  def display_winner(player)
    puts "#{player.name} is the winner!"
  end

  # when a stalemate is declared
  def display_stalemate
    puts 'STALEMATE'
  end

  # when insuffficient material is declared
  def display_insufficient
    puts 'DRAW (Insufficient Material)'
  end

  # prompts the user if they want to save their game
  def display_save
    puts 'Saving the game will overwrite the existing data...'
    puts 'Are you sure you want to save?'
    puts "'y' -> yes  'n' -> no"
    gets.chomp
  end

  # shows the game has successfully been saved
  def display_saved
    puts 'Game successfully saved'
  end

  # shows list of files
  def display_files
    puts 'Saved Files'
    puts ''
  end

  # shows existing game files
  def display_load
    puts ''
    puts 'We see there is an exsisting game'
    puts "Type the file number you want to load or press 'ENTER' to play a new game"
    puts ''
    gets.chomp
  end

  # prompts user if they want to exit and gets choice to exit or not
  def display_exit
    puts 'WARNING'.colorize(color: :yellow)
    puts 'Are you sure you want to exit the game?'
    puts "'y' -> yes  'n' -> no"
    gets.chomp
  end

  # prints the formatted grave for each player
  def display_grave(grave)
    puts "White #{grave[:player_one].map(&:value).sum} #{grave[:player_one].map(&:icon).join('')} "
    puts "Black #{grave[:player_two].map(&:value).sum} #{grave[:player_two].map(&:icon).join('')} "
    puts ' '
  end

  # prints of the formatted board
  def display_board(board, i = 7)
    puts "   #{('A'..'H').to_a.join('  ')}"
    until i.negative?
      row = []
      board.cells.select { |k, v| row << v.form if k[1] == i }
      puts "#{i + 1} #{row.join('')} #{i + 1}"
      i -= 1
    end
    puts "   #{('A'..'H').to_a.join('  ')}"
  end
end
