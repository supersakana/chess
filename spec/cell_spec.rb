# frozen_string_literal: true

# rspec spec/cell_spec.rb
# rspec --format documentation spec/cell_spec.rb

# rubocop:disable Metrics/BlockLength
require_relative '../lib/cell'

describe Cell do
  subject(:cell) { described_class.new([0, 0]) }
  describe '#create_piece' do
    context 'when an start position is input' do
      before do
        allow(cell).to receive(:set_color).and_return(:light_white)
      end
      it 'returns a Rook' do
        cell.instance_variable_set(:@value, [0, 0])
        let(:mock_rook) { instance_double(Rook) }
        expect()
      end
      it 'returns a Bishop' do
        # test to run
      end
      it 'returns a Knight' do
        # test to run
      end
      it 'returns a King' do
        # test to run
      end
      it 'returns a Queen' do
        # test to run
      end
      it 'returns a Pawn' do
        # testto run
      end
    end
    context 'when a vaccant position is input' do
      it 'returns a nil position' do
        # test to run
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
