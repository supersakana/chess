# frozen_string_literal: true

# contains player functionality
class Player
  attr_reader :name, :team

  def initialize(name, team)
    @name = name
    @team = team
  end
end
