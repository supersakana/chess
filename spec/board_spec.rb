# frozen_string_literal: true

# rspec --format documentation spec/board_spec.rb

require_relative '../lib/library'

require 'pry-byebug'

# rubocop:disable Metrics/BlockLength

describe Board do
  subject(:board) { described_class.new }

  # let(:w_rook) { instance_double(Rook, color: :light_white) }
  # let(:w_bishop) { instance_double(Bishop, color: :light_white) }
  # let(:w_queen) { instance_double(Queen, color: :light_white) }
  # let(:w_king) { instance_double(King, color: :light_white) }
  # let(:w_knight) { instance_double(Knight, color: :light_white) }
  # let(:w_pawn) { instance_double(Pawn, color: :light_white) }

  # let(:b_rook) { instance_double(Rook, color: :black) }
  # let(:b_bishop) { instance_double(Bishop, color: :black) }
  # let(:b_queen) { instance_double(Queen, color: :black) }
  # let(:b_king) { instance_double(King, color: :black) }
  # let(:b_knight) { instance_double(Knight, color: :black) }
  # let(:b_pawn) { instance_double(Pawn, color: :black) }

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
    before do
      board.instance_variable_get(:@cells)
    end
    context 'when a selected piece is in starting position' do
      it 'returns empty list (Rook)' do
        move = [0, 0]
        result = board.legals(move)
        expect(result).to eq([])
      end
      it 'returns empty list (Bishop)' do
        move = [2, 0]
        result = board.legals(move)
        expect(result).to eq([])
      end
      it 'returns empty list (Queen)' do
        move = [3, 0]
        result = board.legals(move)
        expect(result).to eq([])
      end
      it 'returns empty list (King)' do
        move = [4, 0]
        result = board.legals(move)
        expect(result).to eq([])
      end
      it 'returns vaccant moves (Knight)' do
        move = [6, 0]
        result = board.legals(move)
        expect(result).to eq([[7, 2], [5, 2]])
      end
    end
    context 'when position is located in a random cell' do
      it 'returns correct locations (Rook [3, 3])' do
        rook = board.cells[[0, 0]].piece
        move = [3, 3]
        board.cells[move].piece = rook
        result = board.legals(move)
        expect(result).to eq([
                               [3, 4], [3, 5], [3, 6],
                               [4, 3], [5, 3], [6, 3], [7, 3],
                               [3, 2],
                               [2, 3], [1, 3], [0, 3]
                             ])
      end
      it 'returns correct locations (Bishop [5, 4])' do
        bishop = board.cells[[2, 7]].piece
        move = [5, 4]
        board.cells[move].piece = bishop
        result = board.legals(move)
        expect(result).to eq([
                               [6, 5],
                               [6, 3], [7, 2],
                               [4, 3], [3, 2], [2, 1],
                               [4, 5]
                             ])
      end
      it 'returns correct locations (Queen [3, 4])' do
        queen = board.cells[[3, 0]].piece
        move = [3, 4]
        board.cells[move].piece = queen
        result = board.legals(move)
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
        move = [6, 2]
        board.cells[move].piece = king
        result = board.legals(move)
        expect(result).to eq([
                               [6, 3], [7, 3], [7, 2], [7, 1], [6, 1], [5, 1], [5, 2], [5, 3]
                             ])
      end
      it 'returns correct locations (Knight [5, 5])' do
        knight = board.cells[[1, 0]].piece
        move = [5, 5]
        board.cells[move].piece = knight
        result = board.legals(move)
        expect(result).to eq([
                               [6, 7], [7, 6], [7, 4], [6, 3], [4, 3], [3, 4], [3, 6], [4, 7]
                             ])
      end
    end
    context 'when given a pawn position' do
      it 'runs #iterate_pawn instead of #iterate_position' do
        move = [1, 1]
        expect(board).to receive(:iterate_pawn).exactly(4).times
        board.legals(move)
      end
    end
    context 'when given a pawns starting position' do
      it 'returns the correct output ([1, 1] White)' do
        move = [1, 1]
        result = board.legals(move)
        expect(result).to eq([[1, 2], [1, 3]])
      end
      it 'returns the correct output ([6, 6] Black)' do
        move = [6, 6]
        result = board.legals(move)
        expect(result).to eq([[6, 5], [6, 4]])
      end
    end
    context 'when given a pawn at a random location' do
      it 'returns correct locations (White Pawn [1, 5])' do
        pawn = board.cells[[1, 1]].piece
        move = [1, 5]
        board.cells[move].piece = pawn
        result = board.legals(move)
        expect(result).to eq([[2, 6], [0, 6]])
      end
      it 'returns correct locations (Black Pawn [1, 5])' do
        pawn = board.cells[[6, 6]].piece
        move = [6, 2]
        board.cells[move].piece = pawn
        result = board.legals(move)
        expect(result).to eq([[7, 1], [5, 1]])
      end
      it 'returns correct locations (White Pawn [3, 3])' do
        w_pawn = board.cells[[1, 1]].piece
        b_pawn = board.cells[[6, 6]].piece
        board.cells[[4, 4]].piece = b_pawn
        move = [3, 3]
        board.cells[move].piece = w_pawn
        allow(board.cells[move]).to receive(:piece_transitions).and_return([[0, 1], [1, 1], [-1, 1]])

        result = board.legals(move)
        expect(result).to eq([[3, 4], [4, 4]])
      end
      it 'returns correct locations (Black Pawn [4, 4]' do
        w_pawn = board.cells[[1, 1]].piece
        b_pawn = board.cells[[6, 6]].piece
        board.cells[[3, 3]].piece = w_pawn
        move = [4, 4]
        board.cells[move].piece = b_pawn
        allow(board.cells[move]).to receive(:piece_transitions).and_return([[0, -1], [1, -1], [-1, -1]])

        result = board.legals(move)
        expect(result).to eq([[4, 3], [3, 3]])
      end
    end
  end

  describe 'iterate_position' do
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
