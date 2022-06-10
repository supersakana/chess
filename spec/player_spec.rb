# frozen_string_literal: true

# rspec --format documentation spec/player_spec.rb

require_relative '../lib/library'
require 'pry-byebug'
# rubocop:disable Metrics/BlockLength

describe Player do
  subject(:player) { described_class.new('Zac', 'White') }
  describe '#input' do
    context 'when the player is called to make a move' do
      before do
        allow(player).to receive(:display_choice).and_return('a2a3')
      end
      it 'recives a prompt for the player to make move' do
        expect(player).to receive(:display_choice)
        player.input
      end
      it 'translates the player input' do
        expect(player).to receive(:translate)
        player.input
      end
      it 'returns the translated input when given a valid input' do
        result = player.input
        expect(result).to eql([[0, 1], [0, 2]])
      end
      it 'returns nil if input is invalid' do
        allow(player).to receive(:display_choice).and_return('a1a2a3')
        result = player.input
        expect(result).to be_nil
      end
    end
  end
  describe '#translate' do
    context 'when given a valid input' do
      it 'returns the correct output (a2a3 => [[0, 1], [0, 2]])' do
        input = 'a2a3'
        result = player.translate(input)
        expect(result).to eql([[0, 1], [0, 2]])
      end
      it 'returns the correct output (g8f6 => [[6, 7], [5, 5]])' do
        input = 'g8f6'
        result = player.translate(input)
        expect(result).to eql([[6, 7], [5, 5]])
      end
      it 'returns the correct output (d1g5 => [[3, 0], [6, 4]])' do
        input = 'd1g5'
        result = player.translate(input)
        expect(result).to eql([[3, 0], [6, 4]])
      end
    end
  end
  describe '#valid_input?' do
    context 'when given a valid input' do
      it 'returns true (a2a3)' do
        input = 'a2a3'
        result = player.valid_input?(input)
        expect(result).to be_truthy
      end
      it 'returns true (g8f6)' do
        input = 'g8f6'
        result = player.valid_input?(input)
        expect(result).to be_truthy
      end
      it 'returns true (d1g5)' do
        input = 'd1g5'
        result = player.valid_input?(input)
        expect(result).to be_truthy
      end
    end
    context 'it returns false when' do
      it 'input length is more than 4' do
        input = 'a1a2a3'
        result = player.valid_input?(input)
        expect(result).to be_falsey
      end
      it 'input length is less than 4' do
        input = 'a1'
        result = player.valid_input?(input)
        expect(result).to be_falsey
      end
      it 'input inlcudes special chars' do
        input = 'a#!&'
        result = player.valid_input?(input)
        expect(result).to be_falsey
      end
      it 'input includes out of bound chars' do
        input = 'z9p0'
        result = player.valid_input?(input)
        expect(result).to be_falsey
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
