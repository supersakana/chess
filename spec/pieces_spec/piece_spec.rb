# frozen_string_literal: true

# rspec --format documentation spec/pieces_spec/piece_spec.rb

require_relative '../../lib/library'

describe Piece do
  subject(:piece) { described_class.new([0, 0]) }
  describe '#create_color' do
    context 'when row (value[0]) is less than 2' do
      it 'returns light_white' do
        value = [0, 0]
        result = piece.create_color(value)
        expect(result).to eq(:light_white)
      end
    end
    context 'when row (value[0]) is more than 2' do
      it 'returns black' do
        value = [7, 0]
        result = piece.create_color(value)
        expect(result).to eq(:black)
      end
    end
  end
end
