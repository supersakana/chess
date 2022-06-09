# frozen_string_literal: true

# rspec --format documentation spec/player_spec.rb

require_relative '../lib/library'

# rubocop:disable Metrics/BlockLength

describe Player do
  subject(:player) { described_class.new('Zac', 'White') }
  describe '#make_move' do
    context 'when the player is called to make a move' do
      before do
        allow(player).to receive(:display_choice).and_return('a2a3')
      end
      it 'recives a prompt for the player to make move' do
        expect(player).to receive(:display_choice)
        player.make_move
      end
      it 'translates the player input' do
        expect(player).to receive(:translate)
        player.make_move
      end
    end
  end
  describe '#translate' do
    context 'when given a valid input' do
      it 'returns the correct output (a2a3 => [[0, 1], [0, 2]])' do
        choice = 'a2a3'
        result = player.translate(choice)
        expect(result).to eql([[0, 1], [0, 2]])
      end
      it 'returns the correct output (g8f6 => [[6, 7], [5, 5]])' do
        choice = 'g8f6'
        result = player.translate(choice)
        expect(result).to eql([[6, 7], [5, 5]])
      end
      it 'returns the correct output (d1g5 => [[3, 0], [6, 4]])' do
        choice = 'd1g5'
        result = player.translate(choice)
        expect(result).to eql([[3, 0], [6, 4]])
      end
    end
  end
  describe '#valid_input?' do
    context 'when given a valid input' do
      it 'returns true (a2a3)' do
        choice = 'a2a3'
        result = player.valid_input?(choice)
        expect(result).to be_truthy
      end
      it 'returns true (g8f6)' do
        choice = 'g8f6'
        result = player.valid_input?(choice)
        expect(result).to be_truthy
      end
      it 'returns true (d1g5)' do
        choice = 'd1g5'
        result = player.valid_input?(choice)
        expect(result).to be_truthy
      end
    end
    context 'it returns false when' do
      it 'input length is more than 4' do
        choice = 'a1a2a3'
        result = player.valid_input?(choice)
        expect(result).to be_falsey
      end
      it 'input length is less than 4' do
        choice = 'a1'
        result = player.valid_input?(choice)
        expect(result).to be_falsey
      end
      it 'input inlcudes special chars' do
        choice = 'a#!&'
        result = player.valid_input?(choice)
        expect(result).to be_falsey
      end
      it 'input includes out of bound chars' do
        choice = 'z9p0'
        result = player.valid_input?(choice)
        expect(result).to be_falsey
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
