# frozen_string_literal: true

# rspec --format documentation spec/player_spec.rb

require_relative '../lib/library'
require 'pry-byebug'

describe Player do
  let(:piece_one) { double('pawn', position: [0, 1], possible_moves: [[0, 2]]) }
  let(:piece_two) { double('knight', position: [6, 7], possible_moves: [[5, 5]]) }
  let(:piece_three) { instance_double('queen', position: [3, 0], possible_moves: [[6, 4]]) }
  subject(:player) { described_class.new('Zac', :light_white, [piece_one, piece_two, piece_three]) }
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
        input = 'd1g4'
        result = player.translate(input)
        expect(result).to eql([[3, 0], [6, 3]])
      end
    end
  end
end
