# frozen_string_literal: true

# rspec --format documentation spec/pieces_spec/king_spec.rb

require_relative '../../lib/library'

# rubocop:disable Metrics/BlockLength

describe King do
  subject(:king) { described_class.new([1, 0]) }
  describe '#possible_moves' do
    context 'when given starting king positions' do
      it 'returns possible king moves between 0-7 (bottom)' do
        king.instance_variable_set(:@position, [4, 0])
        moves = [
          [4, 1], [5, 1], [5, 0], [3, 0], [3, 1]
        ]
        result = king.possible_moves
        expect(result).to eq(moves)
      end
      it 'returns possible king moves between 0-7 (top)' do
        king.instance_variable_set(:@position, [4, 7])
        moves = [
          [5, 7], [5, 6], [4, 6], [3, 6], [3, 7]
        ]
        result = king.possible_moves
        expect(result).to eq(moves)
      end
    end
    context 'when given positions away from the corners' do
      it 'returns possible king moves (3, 3)' do
        king.instance_variable_set(:@position, [3, 3])
        moves = [
          [3, 4], [4, 4], [4, 3], [4, 2], [3, 2], [2, 2], [2, 3], [2, 4]
        ]
        result = king.possible_moves
        expect(result).to eq(moves)
        king.possible_moves
      end
      it 'returns possible king moves (4, 4)' do
        king.instance_variable_set(:@position, [4, 4])
        moves = [
          [4, 5], [5, 5], [5, 4], [5, 3], [4, 3], [3, 3], [3, 4], [3, 5]
        ]
        result = king.possible_moves
        expect(result).to eq(moves)
        king.possible_moves
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
