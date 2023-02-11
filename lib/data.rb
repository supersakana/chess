# frozen_string_literal: true

require 'yaml'

# contains methods that support the user given special inputs
module Data
  include Display
  # initializes a new game file to be saved
  def save_game(game)
    Dir.mkdir 'output' unless Dir.exist? 'output'
    saved_game = game.to_yaml
    filename = "#{@player_one.name}_vs_#{@player_two.name}.yaml"

    File.write(File.open("output/#{filename}", 'w+'), saved_game)
    display_saved
  end

  # shows a list of files in the output folder
  def show_files
    display_files
    Dir.entries('output').each_with_index do |file, index|
      next if [0, 1].include?(index)

      puts "#{index - 1}) #{file[0..-6]}"
    end
  end

  # opens a file given file number
  def open_file(choice)
    saved_file = Dir.entries('output')[choice + 1]
    game = YAML.load(File.read("output/#{saved_file}"))

    game.current = game.turn_player
    game.game_loop
    File.delete("output/#{saved_file}") if File.exist?("output/#{saved_file}")
  end
end
