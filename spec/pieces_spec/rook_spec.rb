# frozen_string_literal: true

# rspec --format documentation spec/pieces_spec/rook_spec.rb

require_relative '../../lib/library'

# rubocop:disable Metrics/BlockLength

describe Rook do
  subject(:rook) { described_class.new([0, 0]) }
  describe '#possible_moves' do
    context 'when given starting rook positions' do
      it 'returns possible rook moves between 0-7 (bottom left)' do
        rook.instance_variable_set(:@position, [0, 0])
        moves = [
          [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
          [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]
        ]
        result = rook.possible_moves
        expect(result).to eq(moves)
      end
      it 'returns possible rook moves between 0-7 (bottom right)' do
        rook.instance_variable_set(:@position, [7, 0])
        moves = [
          [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7],
          [6, 0], [5, 0], [4, 0], [3, 0], [2, 0], [1, 0], [0, 0]
        ]
        result = rook.possible_moves
        expect(result).to eq(moves)
      end
      it 'returns possible rook moves between 0-7 (top left)' do
        rook.instance_variable_set(:@position, [0, 7])
        moves = [
          [1, 7], [2, 7], [3, 7], [4, 7], [5, 7], [6, 7], [7, 7],
          [0, 6], [0, 5], [0, 4], [0, 3], [0, 2], [0, 1], [0, 0]
        ]
        result = rook.possible_moves
        expect(result).to eq(moves)
      end
      it 'returns possible rook moves between 0-7 (top right)' do
        rook.instance_variable_set(:@position, [7, 7])
        moves = [
          [7, 6], [7, 5], [7, 4], [7, 3], [7, 2], [7, 1], [7, 0],
          [6, 7], [5, 7], [4, 7], [3, 7], [2, 7], [1, 7], [0, 7]
        ]
        result = rook.possible_moves
        expect(result).to eq(moves)
        rook.possible_moves
      end
    end
    context 'when given positions away from the corners' do
      it 'returns possible rook moves (3, 3)' do
        rook.instance_variable_set(:@position, [3, 3])
        moves = [
          [3, 4], [3, 5], [3, 6], [3, 7],
          [4, 3], [5, 3], [6, 3], [7, 3],
          [3, 2], [3, 1], [3, 0],
          [2, 3], [1, 3], [0, 3]
        ]
        result = rook.possible_moves
        expect(result).to eq(moves)
        rook.possible_moves
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
