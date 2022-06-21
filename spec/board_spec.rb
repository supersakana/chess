# frozen_string_literal: true

# rspec --format documentation spec/board_spec.rb

require_relative '../lib/library'

require 'pry-byebug'

# rubocop:disable Metrics/BlockLength

describe Board do
  subject(:board) { described_class.new }

  before do
    board.instance_variable_get(:@cells)
  end

  describe '#valid?' do
    context 'when given an input that is not a length of 4' do
      it 'returns false (length = 3)' do
        input = 'a2a'
        result = board.valid?(input, :light_white)
        expect(result).to be_falsey
      end
      it 'returns false (length = 5)' do
        input = 'a2a3b'
        result = board.valid?(input, :light_white)
        expect(result).to be_falsey
      end
    end
    context 'when given an input that is illegal' do
      it 'returns false (White Rook a3a8)' do
        w_rook = board.cells[[0, 0]]
        board.cells[[0, 2]] = w_rook
        input = 'a3a8'
        result = board.valid?(input, :light_white)
        expect(result).to be_falsey
      end
      it 'returns false (Black Bishop c5g1)' do
        b_bishop = board.cells[[5, 7]]
        board.cells[[2, 4]] = b_bishop
        input = 'c5g1'
        result = board.valid?(input, :black)
        expect(result).to be_falsey
      end
      it 'returns false (White Queen g6e8)' do
        w_queen = board.cells[[0, 3]]
        board.cells[[6, 5]] = w_queen
        input = 'g6e8'
        result = board.valid?(input, :light_white)
        expect(result).to be_falsey
      end
      it 'returns false (Black King f3e1)' do
        b_king = board.cells[[4, 7]]
        board.cells[[5, 2]] = b_king
        input = 'f3e1'
        result = board.valid?(input, :black)
        expect(result).to be_falsey
      end
      it 'returns false (White Knight g3e2)' do
        w_knight = board.cells[[1, 0]]
        board.cells[[6, 2]] = w_knight
        input = 'g3e2'
        result = board.valid?(input, :light_white)
        expect(result).to be_falsey
      end
      it 'returns false (Black Pawn d3d2)' do
        b_pawn = board.cells[[6, 6]]
        board.cells[[3, 2]] = b_pawn
        input = 'd3d2'
        result = board.valid?(input, :black)
        expect(result).to be_falsey
      end
    end
    context 'when a user attempts to play opponent pieces' do
      it 'returns false (white picks black piece)' do
        input = 'd7d6'
        result = board.valid?(input, :light_white)
        expect(result).to be_falsey
      end
      it 'returns false (black picks white piece)' do
        input = 'e2e3'
        result = board.valid?(input, :black)
        expect(result).to be_falsey
      end
    end
    context 'when a user inputs a valid move' do
      it 'returns true (Black Rook h6h2)' do
        b_rook = board.cells[[7, 7]]
        board.cells[[7, 5]] = b_rook
        input = 'h6h2'
        result = board.valid?(input, :black)
        expect(result).to be_truthy
      end
      it 'returns true (White Bishop f4c7)' do
        w_bishop = board.cells[[2, 0]]
        board.cells[[5, 3]] = w_bishop
        input = 'f4c7'
        result = board.valid?(input, :light_white)
        expect(result).to be_truthy
      end
      it 'returns true (Black Queen d5d2)' do
        b_queen = board.cells[[3, 7]]
        board.cells[[3, 4]] = b_queen
        input = 'd5d2'
        result = board.valid?(input, :black)
        expect(result).to be_truthy
      end
      it 'returns true (White King e3f3)' do
        w_king = board.cells[[4, 0]]
        board.cells[[4, 2]] = w_king
        input = 'e3f3'
        result = board.valid?(input, :light_white)
        expect(result).to be_truthy
      end
      it 'returns true (Black Knight e3d1)' do
        b_knight = board.cells[[1, 7]]
        board.cells[[4, 2]] = b_knight
        input = 'e3d1'
        result = board.valid?(input, :black)
        expect(result).to be_truthy
      end
      it 'returns true (White Pawn h6g7)' do
        w_pawn = board.cells[[1, 1]]
        board.cells[[7, 5]] = w_pawn
        input = 'h6g7'
        result = board.valid?(input, :light_white)
        expect(result).to be_truthy
      end
    end
  end

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
        # b_pawn = [6, 6]
        # board.cells[[0, 2]]
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

  describe '#legals' do
    context 'when a selected piece is in starting position' do
      it 'returns empty list (Rook)' do
        start = [0, 0]
        result = board.legals(start)
        expect(result).to eq([])
      end
      it 'returns empty list (Bishop)' do
        start = [2, 0]
        result = board.legals(start)
        expect(result).to eq([])
      end
      it 'returns empty list (Queen)' do
        start = [3, 0]
        result = board.legals(start)
        expect(result).to eq([])
      end
      it 'returns empty list (King)' do
        start = [4, 0]
        result = board.legals(start)
        expect(result).to eq([])
      end
      it 'returns vaccant moves (Knight)' do
        start = [6, 0]
        result = board.legals(start)
        expect(result).to eq([[7, 2], [5, 2]])
      end
    end
    context 'when position is located in a random cell' do
      it 'returns correct locations (Rook [3, 3])' do
        rook = board.cells[[0, 0]].piece
        start = [3, 3]
        board.cells[start].piece = rook
        result = board.legals(start)
        expect(result).to eq([
                               [3, 4], [3, 5], [3, 6],
                               [4, 3], [5, 3], [6, 3], [7, 3],
                               [3, 2],
                               [2, 3], [1, 3], [0, 3]
                             ])
      end
      it 'returns correct locations (Bishop [5, 4])' do
        bishop = board.cells[[2, 7]].piece
        start = [5, 4]
        board.cells[start].piece = bishop
        result = board.legals(start)
        expect(result).to eq([
                               [6, 5],
                               [6, 3], [7, 2],
                               [4, 3], [3, 2], [2, 1],
                               [4, 5]
                             ])
      end
      it 'returns correct locations (Queen [3, 4])' do
        queen = board.cells[[3, 0]].piece
        start = [3, 4]
        board.cells[start].piece = queen
        result = board.legals(start)
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
        king = board.cells[[4, 7]].piece
        start = [6, 2]
        board.cells[start].piece = king
        result = board.legals(start)
        expect(result).to eq([
                               [6, 3], [7, 3], [7, 2], [7, 1], [6, 1], [5, 1], [5, 2], [5, 3]
                             ])
      end
      it 'returns correct locations (Knight [5, 5])' do
        knight = board.cells[[1, 0]].piece
        start = [5, 5]
        board.cells[start].piece = knight
        result = board.legals(start)
        expect(result).to eq([
                               [6, 7], [7, 6], [7, 4], [6, 3], [4, 3], [3, 4], [3, 6], [4, 7]
                             ])
      end
    end
    context 'when given a pawns starting position' do
      it 'returns the correct output ([1, 1] White)' do
        start = [1, 1]
        result = board.legals(start)
        expect(result).to eq([[1, 2], [1, 3]])
      end
      it 'returns the correct output ([6, 6] Black)' do
        start = [6, 6]
        result = board.legals(start)
        expect(result).to eq([[6, 5], [6, 4]])
      end
    end
    context 'when given a pawn at a random location' do
      it 'returns correct locations (White Pawn [1, 5])' do
        pawn = board.cells[[1, 1]].piece
        start = [1, 5]
        board.cells[start].piece = pawn
        result = board.legals(start)
        expect(result).to eq([[2, 6], [0, 6]])
      end
      it 'returns correct locations (Black Pawn [1, 5])' do
        pawn = board.cells[[6, 6]].piece
        start = [6, 2]
        board.cells[start].piece = pawn
        result = board.legals(start)
        expect(result).to eq([[7, 1], [5, 1]])
      end
      it 'returns correct locations (White Pawn [3, 3])' do
        w_pawn = board.cells[[1, 1]].piece
        b_pawn = board.cells[[6, 6]].piece
        board.cells[[4, 4]].piece = b_pawn
        start = [3, 3]
        board.cells[start].piece = w_pawn
        allow(board.cells[start]).to receive(:piece_transitions).and_return([[0, 1], [1, 1], [-1, 1]])

        result = board.legals(start)
        expect(result).to eq([[3, 4], [4, 4]])
      end
      it 'returns correct locations (Black Pawn [4, 4]' do
        w_pawn = board.cells[[1, 1]].piece
        b_pawn = board.cells[[6, 6]].piece
        board.cells[[3, 3]].piece = w_pawn
        start = [4, 4]
        board.cells[start].piece = b_pawn
        allow(board.cells[start]).to receive(:piece_transitions).and_return([[0, -1], [1, -1], [-1, -1]])

        result = board.legals(start)
        expect(result).to eq([[4, 3], [3, 3]])
      end
    end
  end

  describe '#iterate_pawn' do
    context 'when given a shift with a legal shift' do
      it 'returns move if foe is in diagonal position' do
        # test to run
      end
      it 'returns move if vertical position is open' do
        # test to run
      end
    end
    context 'when given a shift with an illegal move' do
      it 'returns an empty array' do
        # test to run
      end
    end
  end

  describe 'iterate_piece' do
    context 'when input a valid move' do
      it 'returns line of legal moves given the transition' do
        # test to run
      end
      it 'it continues iterating if the next cell is empty' do
        # test to run
      end
      it 'pushes a foe position then breaks iteration' do
        # test to run
      end
      it 'breaks iteration if encounters same colored piece' do
        # test to run
      end
    end
  end

  describe '#create_move' do
    context 'when a valid move is input' do
      it 'returns the iteratied move' do
        # test to run
      end
    end
    context 'when a out of bound move is input' do
      it 'returns the un-iterated moved' do
        # test to run
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
