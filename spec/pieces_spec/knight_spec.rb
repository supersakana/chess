# frozen_string_literal: true

# rspec --format documentation spec/pieces_spec/knight_spec.rb

require_relative '../../lib/library'

# rubocop:disable Metrics/BlockLength

describe Knight do
  subject(:knight) { described_class.new([1, 0]) }
  describe '#possible_moves' do
    context 'when given starting knight positions' do
      it 'returns possible knight moves between 0-7 (bottom left)' do
        knight.instance_variable_set(:@position, [1, 0])
        moves = [
          [2, 2], [3, 1], [0, 2]
        ]
        result = knight.possible_moves
        expect(result).to eq(moves)
      end
      it 'returns possible knight moves between 0-7 (bottom right)' do
        knight.instance_variable_set(:@position, [6, 0])
        moves = [
          [7, 2], [4, 1], [5, 2]
        ]
        result = knight.possible_moves
        expect(result).to eq(moves)
      end
      it 'returns possible knight moves between 0-7 (top left)' do
        knight.instance_variable_set(:@position, [1, 7])
        moves = [
          [3, 6], [2, 5], [0, 5]
        ]
        result = knight.possible_moves
        expect(result).to eq(moves)
      end
      it 'returns possible knight moves between 0-7 (top right)' do
        knight.instance_variable_set(:@position, [6, 7])
        moves = [
          [7, 5], [5, 5], [4, 6]
        ]
        result = knight.possible_moves
        expect(result).to eq(moves)
      end
    end
    context 'when given positions away from the corners' do
      it 'returns possible knight moves (3, 3)' do
        knight.instance_variable_set(:@position, [3, 3])
        moves = [
          [4, 5], [5, 4], [5, 2], [4, 1], [2, 1], [1, 2], [1, 4], [2, 5]
        ]
        result = knight.possible_moves
        expect(result).to eq(moves)
        knight.possible_moves
      end
      it 'returns possible knight moves (4, 4)' do
        knight.instance_variable_set(:@position, [4, 4])
        moves = [
          [5, 6], [6, 5], [6, 3], [5, 2], [3, 2], [2, 3], [2, 5], [3, 6]
        ]
        result = knight.possible_moves
        expect(result).to eq(moves)
        knight.possible_moves
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
