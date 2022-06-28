# frozen_string_literal: true

# rspec --format documentation spec/board_spec.rb

require_relative '../lib/library'

require 'pry-byebug'

# rubocop:disable Metrics/BlockLength

describe Board do
  subject(:board) { described_class.new }

  before do
    board.instance_variable_get(:@cells)
    board.instance_variable_get(:@grave)
  end

  let(:w_rook) { board.cells[[0, 0]].piece }
  let(:w_bishop) { board.cells[[2, 0]].piece }
  let(:w_queen) { board.cells[[3, 0]].piece }
  let(:w_king) { board.cells[[4, 0]].piece }
  let(:w_knight) { board.cells[[6, 0]].piece }
  let(:w_pawn) { board.cells[[0, 1]].piece }

  let(:b_rook) { board.cells[[7, 7]].piece }
  let(:b_bishop) { board.cells[[2, 7]].piece }
  let(:b_queen) { board.cells[[3, 7]].piece }
  let(:b_king) { board.cells[[4, 7]].piece }
  let(:b_knight) { board.cells[[6, 7]].piece }
  let(:b_pawn) { board.cells[[0, 6]].piece }

  describe '#move_piece' do
    context 'when given a valid input' do
      it 'makes the start posiiton empty' do
        input = 'a2a3'
        start = [0, 1]
        board.move_piece(input)
        expect(board.cells[start].empty?).to be_truthy
      end
      it 'occupies the landing cell with the selected piece' do
        input = 'a2a3'
        selected = board.cells[[0, 1]].piece
        landing = board.cells[[0, 2]]
        board.move_piece(input)
        expect(landing.piece).to eq(selected)
      end
      it 'captures piece if landing contains opponent piece' do
        b_pawn = board.cells[[6, 6]].piece
        board.cells[[0, 2]].piece = b_pawn
        input = 'b2a3'
        board.move_piece(input)
        expect(board.grave[:player_one]).to eq(['♟'])
      end
      it 'pawn jump is removed after first move is made' do
        input = 'a2a4'
        landing = board.cells[[0, 3]]
        board.move_piece(input)
        pawn_shifts = landing.piece_transitions
        expect(pawn_shifts).to eq([[0, 1], [1, 1], [-1, 1]])
      end
    end
  end

  describe '#translate' do
    context 'when given a valid inputs' do
      it 'returns the correct output (a2a3 => [[0, 1], [0, 2]])' do
        input = 'a2a3'
        result = board.translate(input)
        expect(result).to eq([[0, 1], [0, 2]])
      end
      it 'returns the correct output (g8f6 => [[6, 7], [5, 5]])' do
        input = 'g8f6'
        result = board.translate(input)
        expect(result).to eq([[6, 7], [5, 5]])
      end
      it 'returns the correct output (d1g5 => [[3, 0], [6, 4]])' do
        input = 'd1g4'
        result = board.translate(input)
        expect(result).to eq([[3, 0], [6, 3]])
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
# rspec --format documentation spec/board_spec.rb
