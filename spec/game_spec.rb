# frozen_string_literal: true

# rspec --format documentation spec/game_spec.rb

require_relative '../lib/library'

# rubocop:disable Metrics/BlockLength

describe Game do
  subject(:game) { described_class.new }
  let(:player_one) { double('first_player', name: 'Alpha') }
  let(:player_two) { double('second_player', name: 'Omega') }
  let(:board) { double('game_board') }

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
    context 'when round is odd' do
      it 'returns player two' do
        game.instance_variable_set(:@round, 1)
        result = game.turn_player
        expect(result).to eq(player_one)
      end
    end
    context 'when round is even' do
      it 'returns player two' do
        game.instance_variable_set(:@round, 2)
        result = game.turn_player
        expect(result).to eq(player_two)
      end
    end
  end

  describe '#translate' do
    context 'when given a valid inputs' do
      it 'returns the correct output (a2a3 => [[0, 1], [0, 2]])' do
        input = 'a2a3'
        result = game.translate(input)
        expect(result).to eq([[0, 1], [0, 2]])
      end
      it 'returns the correct output (g8f6 => [[6, 7], [5, 5]])' do
        input = 'g8f6'
        result = game.translate(input)
        expect(result).to eq([[6, 7], [5, 5]])
      end
      it 'returns the correct output (d1g5 => [[3, 0], [6, 4]])' do
        input = 'd1g4'
        result = game.translate(input)
        expect(result).to eq([[3, 0], [6, 3]])
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
