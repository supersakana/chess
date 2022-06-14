# frozen_string_literal: true

# rspec --format documentation spec/board_spec.rb

require_relative '../lib/library'

require 'pry-byebug'

# rubocop:disable Metrics/BlockLength

describe Board do
  subject(:board) { described_class.new }
  describe '#create_board' do
    context 'when method is called' do
      it 'creates a hash of 64 keys' do
        expect(board.cells.length).to eq(64)
      end
    end
  end
  describe '#translate' do
    context 'when given a valid inputs' do
      it 'returns the correct output (a2a3 => [[0, 1], [0, 2]])' do
        input = 'a2a3'
        result = board.translate(input)
        expect(result).to eql([[0, 1], [0, 2]])
      end
      it 'returns the correct output (g8f6 => [[6, 7], [5, 5]])' do
        input = 'g8f6'
        result = board.translate(input)
        expect(result).to eql([[6, 7], [5, 5]])
      end
      it 'returns the correct output (d1g5 => [[3, 0], [6, 4]])' do
        input = 'd1g4'
        result = board.translate(input)
        expect(result).to eql([[3, 0], [6, 3]])
      end
    end
  end
  describe '#vaccant_moves' do
    before do
      board.instance_variable_get(:@cells)
    end
    context 'when given a valid rook move' do
      it 'returns no moves if surrounded by team pieces' do
        # test to run
      end
    end
  end
  describe '#assign_i' do
    before do
      board.instance_variable_get(:@cells)
    end
    context 'when given a rook, bishop, or queen coordinate' do
      it 'returns 7 (White Rook)' do
        move = [0, 0]
        result = board.assign_i(move)
        expect(result).to eql(7)
      end
      it 'returns 7 (White Bishop)' do
        move = [2, 0]
        result = board.assign_i(move)
        expect(result).to eql(7)
      end
      it 'returns 7 (White Queen)' do
        move = [3, 0]
        result = board.assign_i(move)
        expect(result).to eql(7)
      end
      it 'returns 7 (Black Rook)' do
        move = [7, 7]
        result = board.assign_i(move)
        expect(result).to eql(7)
      end
      it 'returns 7 (Black Bishop)' do
        move = [5, 7]
        result = board.assign_i(move)
        expect(result).to eql(7)
      end
      it 'returns 7 (Black Queen)' do
        move = [3, 7]
        result = board.assign_i(move)
        expect(result).to eql(7)
      end
    end
    context 'when given a king, knight, or pawn' do
      it 'returns 1 (White King)' do
        move = [4, 0]
        result = board.assign_i(move)
        expect(result).to eql(1)
      end
      it 'returns 1 (White Knight)' do
        move = [1, 0]
        result = board.assign_i(move)
        expect(result).to eql(1)
      end
      it 'returns 1 (White Pawn)' do
        move = [1, 1]
        result = board.assign_i(move)
        expect(result).to eql(1)
      end
      it 'returns 1 (Black King)' do
        move = [4, 7]
        result = board.assign_i(move)
        expect(result).to eql(1)
      end
      it 'returns 1 (Black Knight)' do
        move = [6, 7]
        result = board.assign_i(move)
        expect(result).to eql(1)
      end
      it 'returns 1 (Black Pawn)' do
        move = [6, 6]
        result = board.assign_i(move)
        expect(result).to eql(1)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
