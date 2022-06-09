# frozen_string_literal: true

# rspec --format documentation spec/game_spec.rb

require_relative '../lib/library'

# rubocop:disable Metrics/BlockLength

describe Game do
  subject(:game) { described_class.new }
  let(:player_one) { double('first_player', name: 'Alpha') }
  let(:player_two) { double('second_player', name: 'Omega') }
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
        allow(game).to receive(:one_player)
        expect(game).to receive(:display_invalid).once
        game.game_choice
      end
    end
  end
  describe '#create_player' do
    context 'when a new player is created' do
      before do
        allow(game).to receive(:display_name).and_return('Stranger')
      end
      it 'creates an object of the player class' do
        player = game.create_player(1, 'White')
        expect(player).to be_a(Player)
      end
      it 'has a name' do
        player = game.create_player(1, 'White')
        expect(player.name).to eq('Stranger')
      end
      it 'has a team' do
        player = game.create_player(1, 'White')
        expect(player.team).to eq('White')
      end
    end
  end
  describe '#turn_player' do
    before do
      game.instance_variable_set(:@player_one, player_one)
      game.instance_variable_set(:@player_two, player_two)
    end
    context 'when the round number is odd' do
      it 'returns player one' do
        game.instance_variable_set(:@round, 1)
        result = game.turn_player
        expect(result).to eq(player_one)
      end
    end
    context 'when the round number is even' do
      it 'returns player two' do
        game.instance_variable_set(:@round, 2)
        result = game.turn_player
        expect(result).to eq(player_two)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
