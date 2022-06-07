# frozen_string_literal: true

# rspec --format documentation spec/pieces_spec/pawn_spec.rb

require_relative '../../lib/library'

# rubocop:disable Metrics/BlockLength

describe Pawn do
  subject(:pawn) { described_class.new([4, 1]) }
  describe '#possible_moves' do
    context 'when given starting pawn positions' do
      it 'returns possible pawn moves between 0-7 (bottom white)' do
        pawn.instance_variable_set(:@position, [4, 1])
        pawn.instance_variable_set(:@color, :light_white)
        moves = [
          [4, 2], [4, 3], [5, 2], [3, 2]
        ]
        result = pawn.possible_moves
        expect(result).to eq(moves)
      end
      it 'returns possible pawn moves between 0-7 (top black)' do
        pawn.instance_variable_set(:@position, [4, 6])
        pawn.instance_variable_set(:@color, :black)
        moves = [
          [4, 5], [4, 4], [5, 5], [3, 5]
        ]
        result = pawn.possible_moves
        expect(result).to eq(moves)
      end
    end
    context 'when given a position outside of starting range' do
      it 'returns white possible moves in black territory' do
        pawn.instance_variable_set(:@position, [2, 6])
        pawn.instance_variable_set(:@color, :light_white)
        moves = [
          [2, 7], [3, 7], [1, 7]
        ]
        result = pawn.possible_moves
        expect(result).to eq(moves)
      end
      it 'returns black possible moves in white territory' do
        pawn.instance_variable_set(:@position, [5, 1])
        pawn.instance_variable_set(:@color, :black)
        moves = [
          [5, 0], [6, 0], [4, 0]
        ]
        result = pawn.possible_moves
        expect(result).to eq(moves)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
