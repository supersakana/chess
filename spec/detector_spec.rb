# frozen_string_literal: true

# rspec --format documentation spec/detector_spec.rb

require_relative '../lib/library'

require 'pry-byebug'

# rubocop:disable Metrics/BlockLength

describe Detector do
  subject(:detect) { described_class.new }
  let(:board) { Board.new }

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

  describe '#valid?' do
    context 'when given an input that is not a length of 4' do
      it 'returns false (length = 3)' do
        input = 'a2a'
        result = detect.valid?(input, :light_white, board)
        expect(result).to be_falsey
      end
      it 'returns false (length = 5)' do
        input = 'a2a3b'
        result = detect.valid?(input, :light_white, board)
        expect(result).to be_falsey
      end
    end
    context 'when given an input that is illegal' do
      it 'returns false (White Rook a3a8)' do
        board.cells[[0, 2]].piece = w_rook
        input = 'a3a8'
        result = detect.valid?(input, :light_white, board)
        expect(result).to be_falsey, board
      end
      it 'returns false (Black Bishop c5g1)' do
        board.cells[[2, 4]].piece = b_bishop
        input = 'c5g1'
        result = detect.valid?(input, :black, board)
        expect(result).to be_falsey
      end
      it 'returns false (White Queen g6e8)' do
        board.cells[[6, 5]].piece = w_queen
        input = 'g6e8'
        result = detect.valid?(input, :light_white, board)
        expect(result).to be_falsey
      end
      it 'returns false (Black King f3e1)' do
        board.cells[[5, 2]].piece = b_king
        input = 'f3e1'
        result = detect.valid?(input, :black, board)
        expect(result).to be_falsey
      end
      it 'returns false (White Knight g3e2)' do
        board.cells[[6, 2]].piece = w_knight
        input = 'g3e2'
        result = detect.valid?(input, :light_white, board)
        expect(result).to be_falsey
      end
      it 'returns false (Black Pawn d3d2)' do
        board.cells[[3, 2]].piece = b_pawn
        input = 'd3d2'
        result = detect.valid?(input, :black, board)
        expect(result).to be_falsey
      end
    end
    context 'when a user attempts to play opponent pieces' do
      it 'returns false (white picks black piece)' do
        input = 'd7d6'
        result = detect.valid?(input, :light_white, board)
        expect(result).to be_falsey
      end
      it 'returns false (black picks white piece)' do
        input = 'e2e3'
        result = detect.valid?(input, :black, board)
        expect(result).to be_falsey
      end
    end
    context 'when a user inputs a valid move' do
      it 'returns true (Black Rook h6h2)' do
        board.cells[[7, 5]].piece = b_rook
        input = 'h6h2'
        result = detect.valid?(input, :black, board)
        expect(result).to be_truthy
      end
      it 'returns true (White Bishop f4c7)' do
        board.cells[[5, 3]].piece = w_bishop
        input = 'f4c7'
        result = detect.valid?(input, :light_white, board)
        expect(result).to be_truthy
      end
      it 'returns true (Black Queen d5d2)' do
        board.cells[[3, 4]].piece = b_queen
        input = 'd5d2'
        result = detect.valid?(input, :black, board)
        expect(result).to be_truthy
      end
      it 'returns true (White King e3f3)' do
        board.cells[[4, 2]].piece = w_king
        input = 'e3f3'
        result = detect.valid?(input, :light_white, board)
        expect(result).to be_truthy
      end
      it 'returns true (Black Knight e3d1)' do
        board.cells[[4, 2]].piece = b_knight
        input = 'e3d1'
        result = detect.valid?(input, :black, board)
        expect(result).to be_truthy
      end
      it 'returns true (White Pawn h6g7)' do
        board.cells[[7, 5]].piece = w_pawn
        input = 'h6g7'
        result = detect.valid?(input, :light_white, board)
        expect(result).to be_truthy
      end
    end
    context 'when user is in check and the move unchecks board' do
      before do
        board.cells[[4, 3]].piece = w_rook
        board.cells[[4, 6]].piece = nil
      end
      it 'returns true' do
        input = 'f8e7'
        result = detect.valid?(input, :black, board)
        expect(result).to be_truthy
      end
    end
    context 'when user is in check and the move is still in check' do
      it 'returns false' do
        input = 'e8e7'
        result = detect.valid?(input, :black, board)
        expect(result).to be_falsey
      end
    end
  end

  describe '#legals' do
    context 'when a selected piece is in starting position' do
      it 'returns empty list (Rook)' do
        start = [0, 0]
        result = detect.legals(start, board)
        expect(result).to eq([])
      end
      it 'returns empty list (Bishop)' do
        start = [2, 0]
        result = detect.legals(start, board)
        expect(result).to eq([])
      end
      it 'returns empty list (Queen)' do
        start = [3, 0]
        result = detect.legals(start, board)
        expect(result).to eq([])
      end
      it 'returns empty list (King)' do
        start = [4, 0]
        result = detect.legals(start, board)
        expect(result).to eq([])
      end
      it 'returns vaccant moves (Knight)' do
        start = [6, 0]
        result = detect.legals(start, board)
        expect(result).to eq([[7, 2], [5, 2]])
      end
    end
    context 'when position is located in a random cell' do
      it 'returns correct locations (Rook [3, 3])' do
        start = [3, 3]
        board.cells[start].piece = w_rook
        result = detect.legals(start, board)
        expect(result).to eq([
                               [3, 4], [3, 5], [3, 6],
                               [4, 3], [5, 3], [6, 3], [7, 3],
                               [3, 2],
                               [2, 3], [1, 3], [0, 3]
                             ])
      end
      it 'returns correct locations (Bishop [5, 4])' do
        start = [5, 4]
        board.cells[start].piece = b_bishop
        result = detect.legals(start, board)
        expect(result).to eq([
                               [6, 5],
                               [6, 3], [7, 2],
                               [4, 3], [3, 2], [2, 1],
                               [4, 5]
                             ])
      end
      it 'returns correct locations (Queen [3, 4])' do
        start = [3, 4]
        board.cells[start].piece = w_queen
        result = detect.legals(start, board)
        expect(result).to eq([
                               [3, 5], [3, 6],
                               [4, 5], [5, 6],
                               [4, 4], [5, 4], [6, 4], [7, 4],
                               [4, 3], [5, 2],
                               [3, 3], [3, 2],
                               [2, 3], [1, 2],
                               [2, 4], [1, 4], [0, 4],
                               [2, 5], [1, 6]
                             ])
      end
      it 'returns correct locations (King [6, 2])' do
        start = [6, 2]
        board.cells[start].piece = b_king
        result = detect.legals(start, board)
        expect(result).to eq([
                               [6, 3], [7, 3], [7, 2], [7, 1], [6, 1], [5, 1], [5, 2], [5, 3]
                             ])
      end
      it 'returns correct locations (Knight [5, 5])' do
        start = [5, 5]
        board.cells[start].piece = w_knight
        result = detect.legals(start, board)
        expect(result).to eq([
                               [6, 7], [7, 6], [7, 4], [6, 3], [4, 3], [3, 4], [3, 6], [4, 7]
                             ])
      end
    end
    context 'when given a pawns starting position' do
      it 'returns the correct output ([1, 1] White)' do
        start = [1, 1]
        result = detect.legals(start, board)
        expect(result).to eq([[1, 2], [1, 3]])
      end
      it 'returns the correct output ([6, 6] Black)' do
        start = [6, 6]
        result = detect.legals(start, board)
        expect(result).to eq([[6, 5], [6, 4]])
      end
    end
    context 'when given a pawn at a random location' do
      it 'returns correct locations (White Pawn [1, 5])' do
        start = [1, 5]
        board.cells[start].piece = w_pawn
        result = detect.legals(start, board)
        expect(result).to eq([[2, 6], [0, 6]])
      end
      it 'returns correct locations (Black Pawn [1, 5])' do
        start = [6, 2]
        board.cells[start].piece = b_pawn
        result = detect.legals(start, board)
        expect(result).to eq([[7, 1], [5, 1]])
      end
      it 'returns correct locations (White Pawn [3, 3])' do
        board.cells[[4, 4]].piece = b_pawn
        start = [3, 3]
        board.cells[start].piece = w_pawn
        allow(board.cells[start]).to receive(:piece_transitions).and_return([[0, 1], [1, 1], [-1, 1]])

        result = detect.legals(start, board)
        expect(result).to eq([[3, 4], [4, 4]])
      end
      it 'returns correct locations (Black Pawn [4, 4]' do
        board.cells[[3, 3]].piece = w_pawn
        start = [4, 4]
        board.cells[start].piece = b_pawn
        allow(board.cells[start]).to receive(:piece_transitions).and_return([[0, -1], [1, -1], [-1, -1]])

        result = detect.legals(start, board)
        expect(result).to eq([[4, 3], [3, 3]])
      end
    end
  end

  describe '#check?' do
    context 'when a king is in check' do
      it 'returns true (White Rook vs Black King)' do
        board.cells[[4, 3]].piece = w_rook
        board.cells[[4, 6]].piece = nil
        result = detect.check?(board)
        expect(result).to be_truthy
      end
      it 'returns true (Black Bishop vs White King)' do
        board.cells[[1, 3]].piece = b_bishop
        board.cells[[3, 1]].piece = nil
        result = detect.check?(board)
        expect(result).to be_truthy
      end
      it 'returns true (White Queen vs Black King)' do
        board.cells[[7, 4]].piece = w_queen
        board.cells[[5, 6]].piece = nil
        result = detect.check?(board)
        expect(result).to be_truthy
      end
      it 'returns true (Black Knight vs White King)' do
        board.cells[[5, 2]].piece = b_knight
        result = detect.check?(board)
        expect(result).to be_truthy
      end
      # xit 'returns false for pawns in check position' do
      #   board.cells[[3, 6]].piece = w_pawn
      #   result = detect.check?(board)
      #   expect(result).to be_falsey
      # end
    end
  end
  describe '#un_check?' do
    context 'when given a valid move' do
      it 'returns true (White Rook vs Black King => Bishop unchecks)' do
        board.cells[[4, 3]].piece = w_rook
        board.cells[[4, 6]].piece = nil
        move = 'f8e7'
        result = detect.un_check?(move, board)
        expect(result).to be_truthy
      end
      it 'returns true (Black Bishop vs White King => Knight unchecks)' do
        board.cells[[1, 3]].piece = b_bishop
        board.cells[[3, 1]].piece = nil
        move = 'b1d2'
        result = detect.un_check?(move, board)
        expect(result).to be_truthy
      end
      it 'returns true (White Queen vs Black King => King unchecks' do
        board.cells[[4, 4]].piece = w_queen
        board.cells[[4, 6]].piece = nil
        move = 'd8e7'
        result = detect.un_check?(move, board)
        expect(result).to be_truthy
      end
      it 'returns true (Black Knight vs White King => King unchecks)' do
        board.cells[[3, 2]].piece = b_knight
        board.cells[[4, 1]].piece = nil
        move = 'e1e2'
        result = detect.un_check?(move, board)
        expect(result).to be_truthy
      end
    end
    context 'when given a move that does not uncheck the user' do
      it 'returns false (White Rook vs Black King => Still in Check)' do
        board.cells[[4, 3]].piece = w_rook
        board.cells[[4, 6]].piece = nil
        move = 'e8e7'
        result = detect.un_check?(move, board)
        expect(result).to be_falsey
      end
      it 'returns false (Black Bishop vs White King => Still in Check)' do
        board.cells[[1, 3]].piece = b_bishop
        board.cells[[3, 1]].piece = nil
        move = 'e1d2'
        result = detect.un_check?(move, board)
        expect(result).to be_falsey
      end
    end
  end
  describe '#checkmate?' do
    context 'when given a board that has contains a checkmate' do
      it 'returns true' do
        # test to run
      end
    end
    context 'when given a board that does not contain a checkmate' do
      it 'returns false' do
        # test to run
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
# rspec --format documentation spec/detector_spec.rb
