# frozen_string_literal: true

# rspec spec/cell_spec.rb
# rspec --format documentation spec/cell_spec.rb

require_relative '../lib/cell'

describe Cell do
  subject(:cell) { described_class.new([0, 0]) }
  let(:rook) { double('rook') }
  before do
    cell.instance_variable_get(:@piece)
  end
  describe '#create_piece' do
    context 'when an start position is input' do
      before do
        allow(cell).to receive(:set_color).and_return(:light_white)
      end
      it 'returns a Rook' do
        value = [0, 0]
        cell.create_piece(value)
        expect(cell.piece).to be_a(Rook)
      end
      it 'returns a Bishop' do
        value = [0, 5]
        cell.create_piece(value)
        expect(cell.piece).to be_a(Bishop)
      end
      it 'returns a Knight' do
        value = [7, 1]
        cell.create_piece(value)
        expect(cell.piece).to be_a(Knight)
      end
      it 'returns a King' do
        value = [7, 4]
        cell.create_piece(value)
        expect(cell.piece).to be_a(King)
      end
      it 'returns a Queen' do
        value = [0, 3]
        cell.create_piece(value)
        expect(cell.piece).to be_a(Queen)
      end
      it 'returns a Pawn' do
        value = [6, 1]
        cell.create_piece(value)
        expect(cell.piece).to be_a(Pawn)
      end
    end
    context 'when a vaccant position is input' do
      it 'returns a nil position' do
        value = [5, 0]
        cell.create_piece(value)
        expect(cell.piece).to eq(nil)
      end
    end
  end
end
