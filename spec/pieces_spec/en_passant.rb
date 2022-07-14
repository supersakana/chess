# frozen_string_literal: true

# rspec --format documentation spec/pieces_spec/pawn_spec.rb

require_relative '../../lib/library'

describe EnPassant do
  subject(:en_passant) { described_class.new }
  describe '#en_passant?' do
    context 'when foe pawn is in position but did not jumo' do
      it 'returns false' do
        # test to run
      end
    end
    context 'when en passant doesnt immediatly happen but in correct posiiton' do
      it 'returns false' do
        # test to run
      end
    end
    context 'if user pawn is in correct row, and foe pawn jumps' do
      it 'returns true' do
        # test to run
      end
    end
  end
end
