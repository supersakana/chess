# frozen_string_literal: true

# frozen_string_literal: true

# rspec spec/board_spec/cell_spec.rb
# rspec --format documentation spec/board_spec/cell_spec.rb

require_relative '../../lib/board/cell'

# piece folders
require_relative '../../lib/pieces/rook'
require_relative '../../lib/pieces/knight'
require_relative '../../lib/pieces/bishop'
require_relative '../../lib/pieces/queen'
require_relative '../../lib/pieces/king'
require_relative '../../lib/pieces/pawn'

require 'pry-byebug'

# rubocop:disable Metrics/BlockLength

describe Cell do
  subject(:cell) { described_class.new([0, 0]) }
  before do
    cell.instance_variable_get(:@piece)
  end
  describe '#create_piece' do
    context 'when given a piece starting positions' do
      it 'assigns piece to rook' do
        value = [0, 0]
        cell.create_piece(value)
        expect(cell.piece).to be_a(Rook)
      end
      it 'assigns piece to bishop' do
        value = [0, 2]
        cell.create_piece(value)
        expect(cell.piece).to be_a(Bishop)
      end
      it 'assigns piece to knight' do
        value = [7, 1]
        cell.create_piece(value)
        expect(cell.piece).to be_a(Knight)
      end
      it 'assigns piece to king' do
        value = [7, 4]
        cell.create_piece(value)
        expect(cell.piece).to be_a(King)
      end
      it 'assigns piece to queen' do
        value = [0, 3]
        cell.create_piece(value)
        expect(cell.piece).to be_a(Queen)
      end
      it 'assigns piece to pawn' do
        value = [1, 2]
        cell.create_piece(value)
        expect(cell.piece).to be_a(Pawn)
      end
    end
    context 'when given a vaccant position' do
      it 'assigns piece to nil' do
        value = [2, 3]
        cell.create_piece(value)
        expect(cell.piece).to be_nil
      end
    end
  end
  describe '#set_bg' do
    context 'when value sum is an odd number' do
      it 'returns white' do
        value = [0, 1]
        result = cell.create_bg(value)
        expect(result).to eq(:white)
      end
    end
    context 'when value sum is an even number' do
      it 'returns light_black' do
        value = [0, 0]
        result = cell.create_bg(value)
        expect(result).to eq(:light_black)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
