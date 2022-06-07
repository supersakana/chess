# frozen_string_literal: true

# rspec --format documentation spec/pieces_spec/queen_spec.rb

require_relative '../../lib/library'

# rubocop:disable Metrics/BlockLength

describe Queen do
  subject(:queen) { described_class.new([3, 0]) }
  describe '#possible_moves' do
    context 'when given starting queen positions' do
      it 'returns possible queen moves between 0-7 (bottom)' do
        queen.instance_variable_set(:@position, [3, 0])
        moves = [
          [3, 1], [3, 2], [3, 3], [3, 4], [3, 5], [3, 6], [3, 7],
          [4, 1], [5, 2], [6, 3], [7, 4],
          [4, 0], [5, 0], [6, 0], [7, 0],
          [2, 0], [1, 0], [0, 0],
          [2, 1], [1, 2], [0, 3]
        ]
        result = queen.possible_moves
        expect(result).to eq(moves)
      end
      it 'returns possible queen moves between 0-7 (top)' do
        queen.instance_variable_set(:@position, [3, 7])
        moves = [
          [4, 7], [5, 7], [6, 7], [7, 7],
          [4, 6], [5, 5], [6, 4], [7, 3],
          [3, 6], [3, 5], [3, 4], [3, 3], [3, 2], [3, 1], [3, 0],
          [2, 6], [1, 5], [0, 4],
          [2, 7], [1, 7], [0, 7]

        ]
        result = queen.possible_moves
        expect(result).to eq(moves)
      end
    end
    context 'when given positions away from the corners' do
      it 'returns possible queen moves (3, 3)' do
        queen.instance_variable_set(:@position, [3, 3])
        moves = [

          [3, 4], [3, 5], [3, 6], [3, 7],
          [4, 4], [5, 5], [6, 6], [7, 7],
          [4, 3], [5, 3], [6, 3], [7, 3],
          [4, 2], [5, 1], [6, 0],
          [3, 2], [3, 1], [3, 0],
          [2, 2], [1, 1], [0, 0],
          [2, 3], [1, 3], [0, 3],
          [2, 4], [1, 5], [0, 6]
        ]
        result = queen.possible_moves
        expect(result).to eq(moves)
        queen.possible_moves
      end
      it 'returns possible queen moves (3, 4)' do
        queen.instance_variable_set(:@position, [3, 4])
        moves = [
          [3, 5], [3, 6], [3, 7],
          [4, 5], [5, 6], [6, 7],
          [4, 4], [5, 4], [6, 4], [7, 4],
          [4, 3], [5, 2], [6, 1], [7, 0],
          [3, 3], [3, 2], [3, 1], [3, 0],
          [2, 3], [1, 2], [0, 1],
          [2, 4], [1, 4], [0, 4],
          [2, 5], [1, 6], [0, 7]
        ]
        result = queen.possible_moves
        expect(result).to eq(moves)
        queen.possible_moves
      end
      it 'returns possible queen moves (4, 4)' do
        queen.instance_variable_set(:@position, [4, 4])
        moves = [
          [4, 5], [4, 6], [4, 7],
          [5, 5], [6, 6], [7, 7],
          [5, 4], [6, 4], [7, 4],
          [5, 3], [6, 2], [7, 1],
          [4, 3], [4, 2], [4, 1], [4, 0],
          [3, 3], [2, 2], [1, 1], [0, 0],
          [3, 4], [2, 4], [1, 4], [0, 4],
          [3, 5], [2, 6], [1, 7]
        ]
        result = queen.possible_moves
        expect(result).to eq(moves)
        queen.possible_moves
      end
      it 'returns possible bishop moves (4, 3)' do
        queen.instance_variable_set(:@position, [4, 3])
        moves = [
          [4, 4], [4, 5], [4, 6], [4, 7],
          [5, 4], [6, 5], [7, 6],
          [5, 3], [6, 3], [7, 3],
          [5, 2], [6, 1], [7, 0],
          [4, 2], [4, 1], [4, 0],
          [3, 2], [2, 1], [1, 0],
          [3, 3], [2, 3], [1, 3], [0, 3],
          [3, 4], [2, 5], [1, 6], [0, 7]
        ]
        result = queen.possible_moves
        expect(result).to eq(moves)
        queen.possible_moves
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
