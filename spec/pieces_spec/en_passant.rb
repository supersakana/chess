# frozen_string_literal: true

# rspec --format documentation spec/pieces_spec/pawn_spec.rb

require_relative '../../lib/library'

describe EnPassant do
  subject(:en_passant) { described_class.new }

  let(:board) { Board.new }

  let(:w_pawn) { board.cells[[0, 1]].piece }
  let(:b_pawn) { board.cells[[0, 6]].piece }

  describe '#en_passant?' do
    before do
      board.cells[[4, 4]].piece = w_pawn
      board.cells[[3, 4]].piece = b_pawn
      board.cells[[4, 1]].piece = nil
      board.cells[[3, 6]].piece = nil
    end
    context 'when foe pawn is in position but did not jump' do
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
