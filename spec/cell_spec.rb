# frozen_string_literal: true

# rspec --format documentation spec/cell_spec.rb

require_relative '../lib/library'

# rubocop:disable Metrics/BlockLength

describe Cell do
  subject(:cell) { described_class.new([0, 0]) }
  before do
    cell.instance_variable_get(:@piece)
  end
  describe '#create_piece' do
    context 'when given a Rook starting positions' do
      it 'creates Rook bottom left' do
        value = cell.instance_variable_set(:@value, [0, 0])
        cell.create_piece(value)
        expect(cell.piece).to be_a(Rook)
      end
      it 'creates Rook bottom right' do
        value = cell.instance_variable_set(:@value, [0, 7])
        cell.create_piece(value)
        expect(cell.piece).to be_a(Rook)
      end
      it 'creates Rook top left' do
        value = cell.instance_variable_set(:@value, [7, 0])
        cell.create_piece(value)
        expect(cell.piece).to be_a(Rook)
      end
      it 'creates Rook top right' do
        value = cell.instance_variable_set(:@value, [7, 7])
        cell.create_piece(value)
        expect(cell.piece).to be_a(Rook)
      end
    end
    context 'when given a Bishop starting positions' do
      it 'creates Bishop bottom left' do
        value = cell.instance_variable_set(:@value, [2, 0])
        cell.create_piece(value)
        expect(cell.piece).to be_a(Bishop)
      end
      it 'creates Bishop bottom right' do
        value = cell.instance_variable_set(:@value, [5, 0])
        cell.create_piece(value)
        expect(cell.piece).to be_a(Bishop)
      end
      it 'creates Bishop top left' do
        value = cell.instance_variable_set(:@value, [2, 7])
        cell.create_piece(value)
        expect(cell.piece).to be_a(Bishop)
      end
      it 'creates Bishop top right' do
        value = cell.instance_variable_set(:@value, [5, 7])
        cell.create_piece(value)
        expect(cell.piece).to be_a(Bishop)
      end
    end
    context 'when given a Knight starting positions' do
      it 'creates Knight bottom left' do
        value = cell.instance_variable_set(:@value, [1, 0])
        cell.create_piece(value)
        expect(cell.piece).to be_a(Knight)
      end
      it 'creates Knight bottom right' do
        value = cell.instance_variable_set(:@value, [6, 0])
        cell.create_piece(value)
        expect(cell.piece).to be_a(Knight)
      end
      it 'creates Knight top left' do
        value = cell.instance_variable_set(:@value, [1, 7])
        cell.create_piece(value)
        expect(cell.piece).to be_a(Knight)
      end
      it 'creates Knight top right' do
        value = cell.instance_variable_set(:@value, [6, 7])
        cell.create_piece(value)
        expect(cell.piece).to be_a(Knight)
      end
    end
    context 'when given a King starting positions' do
      it 'creates King bottom' do
        value = cell.instance_variable_set(:@value, [4, 0])
        cell.create_piece(value)
        expect(cell.piece).to be_a(King)
      end
      it 'creates King top' do
        value = cell.instance_variable_set(:@value, [4, 7])
        cell.create_piece(value)
        expect(cell.piece).to be_a(King)
      end
    end
    context 'when given a Queen starting positions' do
      it 'creates Queen bottom' do
        value = cell.instance_variable_set(:@value, [3, 0])
        cell.create_piece(value)
        expect(cell.piece).to be_a(Queen)
      end
      it 'creates Queen top ' do
        value = cell.instance_variable_set(:@value, [3, 7])
        cell.create_piece(value)
        expect(cell.piece).to be_a(Queen)
      end
    end
    context 'when given a Pawn starting positions' do
      it 'creates Pawn bottom row ' do
        value = cell.instance_variable_set(:@value, [3, 1])
        cell.create_piece(value)
        expect(cell.piece).to be_a(Pawn)
      end
      it 'creates Pawn top row ' do
        value = cell.instance_variable_set(:@value, [3, 6])
        cell.create_piece(value)
        expect(cell.piece).to be_a(Pawn)
      end
    end
    context 'when given an empty position' do
      it 'returns nil ' do
        value = cell.instance_variable_set(:@value, [1, 5])
        cell.create_piece(value)
        expect(cell.piece).to be_nil
      end
    end
  end

  describe '#create_bg' do
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
  describe '#promote?' do
    let(:w_pawn) { double('pawn', color: :light_white, piece_color: :light_white) }
    let(:b_pawn) { double('pawn', color: :black, piece_color: :black) }
    context 'when a white pawn occupies the top row' do
      before do
        cell.instance_variable_set(:@value, [0, 7])
        cell.instance_variable_set(:@piece, w_pawn)
        allow(cell.piece).to receive(:is_a?).and_return(true)
      end
      it 'returns true' do
        result = cell.promote?
        expect(result).to be_truthy
      end
    end
    context 'when a black pawn occupies the bottom row' do
      before do
        cell.instance_variable_set(:@value, [0, 0])
        cell.instance_variable_set(:@piece, b_pawn)
        allow(cell.piece).to receive(:is_a?).and_return(true)
      end
      it 'returns true' do
        result = cell.promote?
        expect(result).to be_truthy
      end
    end
    context 'it returns false when' do
      before do
        allow(cell.piece).to receive(:is_a?).and_return(false)
      end
      it 'there is not a pawn occupying' do
        result = cell.promote?
        expect(result).to be_falsey
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
# rspec --format documentation spec/cell_spec.rb
