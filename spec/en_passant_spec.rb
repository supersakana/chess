# frozen_string_literal: true

# rspec --format documentation spec/en_passant_spec.rb

require_relative '../lib/library'

require 'pry-byebug'

# rubocop:disable Metrics/BlockLength
describe EnPassant do
  let(:board) { Board.new }

  let(:w_pawn) { board.cells[[0, 1]].piece }
  let(:b_pawn) { board.cells[[0, 6]].piece }

  describe '#ep_true?' do
    before do
      board.cells[[4, 4]].piece = w_pawn
      board.cells[[3, 4]].piece = b_pawn
      board.cells[[4, 1]].piece = nil
      board.cells[[3, 6]].piece = nil
    end
    context 'when foe pawn is in correct en passant position and condition' do
      before do
        b_pawn.instance_variable_set(:@jumped, true)
      end
      it 'returns true' do
        start = [4, 4]
        result = b_pawn.ep_true?(start, board)
        expect(result).to be_truthy
      end
    end
    context 'when foe pawn is in pawn position but did not jump' do
      before do
        b_pawn.instance_variable_set(:@jumped, false)
      end
      it 'returns false' do
        start = [4, 4]
        result = b_pawn.ep_true?(start, board)
        expect(result).to be_falsey
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
