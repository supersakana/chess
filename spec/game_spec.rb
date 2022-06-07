# frozen_string_literal: true

# rspec --format documentation spec/game_spec.rb

require_relative '../lib/library'

describe Game do
  subject(:game) { described_class.new }
  describe '#game_choice' do
    context 'when a valid input is passed' do
      it 'creates a single player game when 1 is passed' do
        allow(game).to receive(:display_games).and_return('1')
        expect(game).to receive(:one_player)
        game.game_choice
      end
      it 'create a two player game when 2 is passed' do
        allow(game).to receive(:display_games).and_return('2')
        expect(game).to receive(:two_players)
        game.game_choice
      end
    end
    context 'when an invalid input is passed' do
      it 'returns an invalid input message' do
        allow(game).to receive(:display_games).and_return('invalid input', '1')
        expect(game).to receive(:display_invalid).once
        game.game_choice
      end
    end
  end
end
