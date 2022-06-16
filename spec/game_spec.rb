# frozen_string_literal: true

# rspec --format documentation spec/game_spec.rb

require_relative '../lib/library'

# rubocop:disable Metrics/BlockLength

describe Game do
  subject(:game) { described_class.new }
  let(:player_one) { double('first_player', name: 'Alpha') }
  let(:player_two) { double('second_player', name: 'Omega') }
  describe '#create_player' do
    context 'when a new player is created' do
      before do
        allow(game).to receive(:display_name).and_return('Stranger')
      end
      it 'creates an object of the player class' do
        player = game.create_player(1, :light_white)
        expect(player).to be_a(Player)
      end
      it 'has a name' do
        player = game.create_player(1, :light_white)
        expect(player.name).to eq('Stranger')
      end
      it 'has a color' do
        player = game.create_player(1, :light_white)
        expect(player.color).to eq(:light_white)
      end
    end
  end
  describe '#turn_player' do
    before do
      game.instance_variable_set(:@player_one, player_one)
      game.instance_variable_set(:@player_two, player_two)
    end
    context 'current player is player one' do
      it 'returns player two' do
        game.instance_variable_set(:@current, player_one)
        result = game.turn_player
        expect(result).to eq(player_two)
      end
    end
    context 'current player is player two' do
      it 'returns player two' do
        game.instance_variable_set(:@current, player_two)
        result = game.turn_player
        expect(result).to eq(player_one)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
