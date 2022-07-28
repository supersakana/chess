# frozen_string_literal: true

require 'pry-byebug'

# contains methods that support the user given special inputs
module Data
  include Display
  # initializes a new game file to be saved
  def save_game
    Dir.mkdir 'output' unless Dir.exist? 'output'
    @filename = "#{@player_one.name}_vs_#{@player_two.name}.yaml"
    File.open("output/#{@filename}", 'w') { |file| file.write save_yaml }
    display_saved
  end

  #   writes the data into a yaml file
  def save_yaml
    YAML.dump(
      player_one: @player_one,
      player_two: @player_one,
      board: @board,
      current: @current
    )
  end
end
