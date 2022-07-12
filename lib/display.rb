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

  # when a winner is declared
  def display_winner(player)
    puts 'CHECKMATE'.colorize(color: :green)
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

  # prints the formatted grave for each player
  def display_grave(grave)
    puts "P1 #{grave[:player_one].join('')} "
    puts "P2 #{grave[:player_two].join('')} "
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
