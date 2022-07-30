# frozen_string_literal: true

# rspec --format documentation spec/legal_spec.rb

require_relative '../lib/library'

# rubocop:disable Metrics/BlockLength

describe Game do
  subject(:game) { described_class.new }

  let(:board) { Board.new }
  let(:detector) { Detector.new }

  let(:player_one) { double('first_player', name: 'Alpha', color: :light_white, foe_color: :black) }
  let(:player_two) { double('second_player', name: 'Omega', color: :black, foe_color: :light_white) }

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

  describe '#legal?' do
    context 'when given an input that is illegal' do
      it 'returns false (White Rook a3a8)' do
        board.cells[[0, 2]].piece = w_rook
        key = [[0, 2], [0, 7]]
        result = game.legal?(key, player_one, board)
        expect(result).to be_falsey
      end
      it 'returns false (Black Bishop c5g1)' do
        board.cells[[2, 4]].piece = b_bishop
        key = [[2, 4], [6, 0]]
        result = game.legal?(key, player_two, board)
        expect(result).to be_falsey
      end
      it 'returns false (White Queen g6e8)' do
        board.cells[[6, 5]].piece = w_queen
        key = [[6, 5], [5, 7]]
        result = game.legal?(key, player_one, board)
        expect(result).to be_falsey
      end
      it 'returns false (Black King f3e1)' do
        board.cells[[5, 2]].piece = b_king
        key = [[5, 2], [4, 0]]
        result = game.legal?(key, player_two, board)
        expect(result).to be_falsey
      end
      it 'returns false (White Knight g3e2)' do
        board.cells[[6, 2]].piece = w_knight
        key = [[6, 2], [4, 1]]
        result = game.legal?(key, player_one, board)
        expect(result).to be_falsey
      end
      it 'returns false (Black Pawn d3d2)' do
        board.cells[[3, 2]].piece = b_pawn
        key = [[3, 2], [3, 1]]
        result = game.legal?(key, player_two, board)
        expect(result).to be_falsey
      end
    end
    context 'when a user attempts to play opponent pieces' do
      it 'returns false (white picks black piece)' do
        key = [[3, 6], [3, 5]]
        result = game.legal?(key, player_one, board)
        expect(result).to be_falsey
      end
      it 'returns false (black picks white piece)' do
        key = [[4, 1], [4, 2]]
        result = game.legal?(key, player_two, board)
        expect(result).to be_falsey
      end
    end
    context 'when a user inputs a valid move' do
      it 'returns true (Black Rook h6h2)' do
        board.cells[[7, 5]].piece = b_rook
        key = [[7, 5], [7, 1]]
        result = game.legal?(key, player_two, board)
        expect(result).to be_truthy
      end
      it 'returns true (White Bishop f4c7)' do
        board.cells[[5, 3]].piece = w_bishop
        key = [[5, 3], [2, 6]]
        result = game.legal?(key, player_one, board)
        expect(result).to be_truthy
      end
      it 'returns true (Black Queen d5d2)' do
        board.cells[[3, 4]].piece = b_queen
        key = [[3, 4], [3, 1]]
        result = game.legal?(key, player_two, board)
        expect(result).to be_truthy
      end
      it 'returns true (White King e3f3)' do
        board.cells[[4, 2]].piece = w_king
        key = [[4, 2], [5, 2]]
        result = game.legal?(key, player_one, board)
        expect(result).to be_truthy
      end
      it 'returns true (Black Knight e3d1)' do
        board.cells[[4, 2]].piece = b_knight
        key = [[4, 2], [3, 0]]
        result = game.legal?(key, player_two, board)
        expect(result).to be_truthy
      end
      it 'returns true (White Pawn h6g7)' do
        board.cells[[7, 5]].piece = w_pawn
        key = [[7, 5], [6, 6]]
        result = game.legal?(key, player_one, board)
        expect(result).to be_truthy
      end
    end
    context 'when user is in check and the move unchecks board' do
      before do
        board.cells[[4, 3]].piece = w_rook
        board.cells[[4, 6]].piece = nil
      end
      it 'returns true' do
        key = [[5, 7], [4, 6]]
        result = game.legal?(key, player_two, board)
        expect(result).to be_truthy
      end
    end
    context 'when user is in check and the move is still in check' do
      before do
        allow(game).to receive(:check?).and_return(true)
      end
      it 'returns false' do
        key = [[7, 7], [7, 6]]
        result = game.legal?(key, player_two, board)
        expect(result).to be_falsey
      end
    end
    context 'when user is in check the move is invalid' do
      before do
        allow(game).to receive(:check?).and_return(true)
      end
      it 'returns false' do
        key = [[7, -1], [7, -1]]
        result = game.legal?(key, player_two, board)
        expect(result).to be_falsey
      end
    end
    context 'when user inputs pawn jump move but a piece is infront of it' do
      before do
        board.cells[[4, 2]].piece = b_pawn
      end
      it 'returns false when user tries to pawn jump over piece' do
        key = [[4, 1], [4, 3]]
        result = game.legal?(key, player_one, board)
        expect(result).to be_falsey
      end
    end
    context 'when given an en passant input with correct condiitons' do
      before do
        board.cells[[4, 4]].piece = w_pawn
        board.cells[[3, 4]].piece = b_pawn
        board.cells[[4, 1]].piece = nil
        board.cells[[3, 6]].piece = nil
      end
      it 'returns true' do
        board.cells[[3, 4]].piece.instance_variable_set(:@jumped, true)
        board.cells[[4, 4]].piece.instance_variable_set(:@ep_enabled, true)
        key = [[4, 4], [3, 5]]
        result = game.legal?(key, player_one, board)
        expect(result).to be_truthy
      end
    end
    context 'when given an castling move' do
      let(:castling) { Board.new }
      before do
        castling.cells[[1, 0]].piece = nil
        castling.cells[[2, 0]].piece = nil
        castling.cells[[3, 0]].piece = nil
        castling.cells[[5, 0]].piece = nil
        castling.cells[[6, 0]].piece = nil
        castling.cells[[1, 7]].piece = nil
        castling.cells[[2, 7]].piece = nil
        castling.cells[[3, 7]].piece = nil
        castling.cells[[5, 7]].piece = nil
        castling.cells[[6, 7]].piece = nil
      end
      it 'returns true (White King Side)' do
        key = [[4, 0], [6, 0]]
        result = game.legal?(key, player_one, castling)
        expect(result).to be_truthy
      end
      it 'returns true (White Queen Side)' do
        key = [[4, 0], [2, 0]]
        result = game.legal?(key, player_one, castling)
        expect(result).to be_truthy
      end
      it 'returns true (Black King Side)' do
        key = [[4, 7], [6, 7]]
        result = game.legal?(key, player_two, castling)
        expect(result).to be_truthy
      end
      it 'returns true (Black Queen Side)' do
        key = [[4, 7], [2, 7]]
        result = game.legal?(key, player_two, castling)
        expect(result).to be_truthy
      end
      it 'returns false if Rook has moved' do
        rook = castling.cells[[0, 0]].piece
        rook.moved = true
        key = [[4, 0], [2, 0]]
        result = game.legal?(key, player_two, castling)
        expect(result).to be_falsey
      end
      it 'returns false if King has moved' do
        king = castling.cells[[4, 0]].piece
        king.moved = true
        key = [[4, 0], [2, 0]]
        result = game.legal?(key, player_one, castling)
        expect(result).to be_falsey
      end
      it 'returns false if King is in check' do
        castling.cells[[3, 2]].piece = b_knight
        key = [[4, 0], [2, 0]]
        result = game.legal?(key, player_one, castling)
        expect(result).to be_falsey
      end
      it 'returns false if landing position puts king in check' do
        castling.cells[[2, 2]].piece = b_knight
        key = [[4, 0], [2, 0]]
        result = game.legal?(key, player_one, castling)
        expect(result).to be_falsey
      end
      it 'returns false if passes through check' do
        castling.cells[[2, 1]].piece = nil
        castling.cells[[1, 2]].piece = b_bishop
        key = [[4, 0], [2, 0]]
        result = game.legal?(key, player_one, castling)
        expect(result).to be_falsey
      end
      it 'returns false if other piece is between king and rook' do
        castling.cells[[2, 0]].piece = w_bishop
        key = [[4, 0], [2, 0]]
        result = game.legal?(key, player_one, castling)
        expect(result).to be_falsey
      end
    end
  end

  describe '#possibles' do
    context 'when a selected piece is in starting position' do
      it 'returns empty list (Rook)' do
        start = [0, 0]
        result = game.possibles(start, board)
        expect(result).to eq([])
      end
      it 'returns empty list (Bishop)' do
        start = [2, 0]
        result = game.possibles(start, board)
        expect(result).to eq([])
      end
      it 'returns empty list (Queen)' do
        start = [3, 0]
        result = game.possibles(start, board)
        expect(result).to eq([])
      end
      it 'returns empty list (King)' do
        start = [4, 0]
        result = game.possibles(start, board)
        expect(result).to eq([])
      end
      it 'returns vaccant moves (Knight)' do
        start = [6, 0]
        result = game.possibles(start, board)
        expect(result).to eq([[7, 2], [5, 2]])
      end
    end
    context 'when position is located in a random cell' do
      it 'returns correct locations (Rook [3, 3])' do
        start = [3, 3]
        board.cells[start].piece = w_rook
        result = game.possibles(start, board)
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
        result = game.possibles(start, board)
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
        result = game.possibles(start, board)
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
        result = game.possibles(start, board)
        expect(result).to eq([
                               [6, 3], [7, 3], [7, 2], [7, 1], [6, 1], [5, 1], [5, 2], [5, 3]
                             ])
      end
      it 'returns correct locations (Knight [5, 5])' do
        start = [5, 5]
        board.cells[start].piece = w_knight
        result = game.possibles(start, board)
        expect(result).to eq([
                               [6, 7], [7, 6], [7, 4], [6, 3], [4, 3], [3, 4], [3, 6], [4, 7]
                             ])
      end
    end
    context 'when given a pawns starting position' do
      it 'returns the correct output ([1, 1] White)' do
        start = [1, 1]
        result = game.possibles(start, board)
        expect(result).to eq([[1, 2], [1, 3]])
      end
      it 'returns the correct output ([6, 6] Black)' do
        start = [6, 6]
        result = game.possibles(start, board)
        expect(result).to eq([[6, 5], [6, 4]])
      end
    end
    context 'when given a pawn at a random location' do
      it 'returns correct locations (White Pawn [1, 5])' do
        start = [1, 5]
        board.cells[start].piece = w_pawn
        result = game.possibles(start, board)
        expect(result).to eq([[2, 6], [0, 6]])
      end
      it 'returns correct locations (Black Pawn [1, 5])' do
        start = [6, 2]
        board.cells[start].piece = b_pawn
        result = game.possibles(start, board)
        expect(result).to eq([[7, 1], [5, 1]])
      end
      it 'returns correct locations (White Pawn [3, 3])' do
        board.cells[[4, 4]].piece = b_pawn
        start = [3, 3]
        board.cells[start].piece = w_pawn
        allow(board.cells[start]).to receive(:piece_shifts).and_return([[0, 1], [1, 1], [-1, 1]])

        result = game.possibles(start, board)
        expect(result).to eq([[3, 4], [4, 4]])
      end
      it 'returns correct locations (Black Pawn [4, 4]' do
        board.cells[[3, 3]].piece = w_pawn
        start = [4, 4]
        board.cells[start].piece = b_pawn
        allow(board.cells[start]).to receive(:piece_shifts).and_return([[0, -1], [1, -1], [-1, -1]])

        result = game.possibles(start, board)
        expect(result).to eq([[4, 3], [3, 3]])
      end
    end
    context 'in a situation where an en passant is valid' do
      it 'returns correct locations (White Pawn [4, 4])' do
        board.cells[[4, 4]].piece = w_pawn
        board.cells[[3, 4]].piece = b_pawn
        board.cells[[4, 1]].piece = nil
        board.cells[[3, 6]].piece = nil
        board.cells[[3, 4]].piece.instance_variable_set(:@jumped, true)
        board.cells[[4, 4]].piece.instance_variable_set(:@jump_enabled, false)
        board.cells[[4, 4]].piece.instance_variable_set(:@ep_enabled, true)
        start = [4, 4]

        result = game.possibles(start, board)
        expect(result).to eq([[4, 5], [3, 5]])
      end
      it 'returns correct locations (Black Pawn [3, 3])' do
        board.cells[[3, 3]].piece = b_pawn
        board.cells[[4, 3]].piece = w_pawn
        board.cells[[4, 1]].piece = nil
        board.cells[[3, 6]].piece = nil
        board.cells[[4, 3]].piece.instance_variable_set(:@jumped, true)
        board.cells[[3, 3]].piece.instance_variable_set(:@jump_enabled, false)
        board.cells[[3, 3]].piece.instance_variable_set(:@ep_enabled, true)
        start = [3, 3]

        result = game.possibles(start, board)
        expect(result).to eq([[3, 2], [4, 2]])
      end
    end
    context 'in a castling situation' do
      before do
        board.cells[[1, 0]].piece = nil
        board.cells[[2, 0]].piece = nil
        board.cells[[3, 0]].piece = nil
        board.cells[[5, 0]].piece = nil
        board.cells[[6, 0]].piece = nil
        board.cells[[1, 7]].piece = nil
        board.cells[[2, 7]].piece = nil
        board.cells[[3, 7]].piece = nil
        board.cells[[5, 7]].piece = nil
        board.cells[[6, 7]].piece = nil
      end
      it 'returns correct locations (White Kingside)' do
        board.cells[[0, 0]].piece.moved = true
        start = [4, 0]
        result = game.possibles(start, board)
        expect(result).to eq([[5, 0], [3, 0], [6, 0]])
      end
      it 'returns correct locations (White Queenside)' do
        board.cells[[7, 0]].piece.moved = true
        start = [4, 0]
        result = game.possibles(start, board)
        expect(result).to eq([[5, 0], [3, 0], [2, 0]])
      end
      it 'returns correct locations (Black Kingside)' do
        board.cells[[0, 7]].piece.moved = true
        start = [4, 7]
        result = game.possibles(start, board)
        expect(result).to eq([[5, 7], [3, 7], [6, 7]])
      end
      it 'returns correct locations (Black Kingside)' do
        board.cells[[7, 7]].piece.moved = true
        start = [4, 7]
        result = game.possibles(start, board)
        expect(result).to eq([[5, 7], [3, 7], [2, 7]])
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
# rspec --format documentation spec/legal_spec.rb
