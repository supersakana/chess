# frozen_string_literal: true

# rspec --format documentation spec/pieces_spec/bishop_spec.rb

require_relative '../../lib/library'

# rubocop:disable Metrics/BlockLength

describe Bishop do
  subject(:bishop) { described_class.new([0, 2]) }
  describe '#possible_moves' do
    context 'when given starting bishop positions' do
      it 'returns possible bishop moves between 0-7 (bottom left)' do
        bishop.instance_variable_set(:@position, [2, 0])
        moves = [
          [3, 1], [4, 2], [5, 3], [6, 4], [7, 5],
          [1, 1], [0, 2]
        ]
        result = bishop.possible_moves
        expect(result).to eq(moves)
      end
      it 'returns possible bishop moves between 0-7 (bottom right)' do
        bishop.instance_variable_set(:@position, [5, 0])
        moves = [
          [6, 1], [7, 2],
          [4, 1], [3, 2], [2, 3], [1, 4], [0, 5]
        ]
        result = bishop.possible_moves
        expect(result).to eq(moves)
      end
      it 'returns possible bishop moves between 0-7 (top left)' do
        bishop.instance_variable_set(:@position, [2, 7])
        moves = [
          [3, 6], [4, 5], [5, 4], [6, 3], [7, 2],
          [1, 6], [0, 5]
        ]
        result = bishop.possible_moves
        expect(result).to eq(moves)
      end
      it 'returns possible bishop moves between 0-7 (top right)' do
        bishop.instance_variable_set(:@position, [5, 7])
        moves = [
          [6, 6], [7, 5],
          [4, 6], [3, 5], [2, 4], [1, 3], [0, 2]
        ]
        result = bishop.possible_moves
        expect(result).to eq(moves)
        bishop.possible_moves
      end
    end
    context 'when given positions away from the corners' do
      it 'returns possible bishop moves (2, 3)' do
        bishop.instance_variable_set(:@position, [2, 3])
        moves = [
          [3, 4], [4, 5], [5, 6], [6, 7],
          [3, 2], [4, 1], [5, 0],
          [1, 2], [0, 1],
          [1, 4], [0, 5]
        ]
        result = bishop.possible_moves
        expect(result).to eq(moves)
        bishop.possible_moves
      end
      it 'returns possible bishop moves (5, 3)' do
        bishop.instance_variable_set(:@position, [5, 3])
        moves = [
          [6, 4], [7, 5],
          [6, 2], [7, 1],
          [4, 2], [3, 1], [2, 0],
          [4, 4], [3, 5], [2, 6], [1, 7]
        ]
        result = bishop.possible_moves
        expect(result).to eq(moves)
        bishop.possible_moves
      end
      it 'returns possible bishop moves (5, 4)' do
        bishop.instance_variable_set(:@position, [5, 4])
        moves = [
          [6, 5], [7, 6],
          [6, 3], [7, 2],
          [4, 3], [3, 2], [2, 1], [1, 0],
          [4, 5], [3, 6], [2, 7]
        ]
        result = bishop.possible_moves
        expect(result).to eq(moves)
        bishop.possible_moves
      end
      it 'returns possible bishop moves (2, 4)' do
        bishop.instance_variable_set(:@position, [2, 4])
        moves = [
          [3, 5], [4, 6], [5, 7],
          [3, 3], [4, 2], [5, 1], [6, 0],
          [1, 3], [0, 2],
          [1, 5], [0, 6]
        ]
        result = bishop.possible_moves
        expect(result).to eq(moves)
        bishop.possible_moves
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
