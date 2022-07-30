# frozen_string_literal: true

# rspec --format documentation spec/gameovers_spec.rb

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

  describe '#checks_self?' do
    context 'when given a valid move' do
      it 'returns false (White Rook vs Black King => Bishop unchecks)' do
        board.cells[[4, 3]].piece = w_rook
        board.cells[[4, 6]].piece = nil
        translated = [[5, 7], [4, 6]]
        result = game.checks_self?(translated, player_two, board)
        expect(result).to be_falsey
      end
      it 'returns false (Black Bishop vs White King => Knight unchecks)' do
        board.cells[[1, 3]].piece = b_bishop
        board.cells[[3, 1]].piece = nil
        translated = [[1, 0], [3, 1]]
        result = game.checks_self?(translated, player_one, board)
        expect(result).to be_falsey
      end
      it 'returns false (White Queen vs Black King => King unchecks' do
        board.cells[[4, 4]].piece = w_queen
        board.cells[[4, 6]].piece = nil
        translated = [[3, 7], [4, 6]]
        result = game.checks_self?(translated, player_two, board)
        expect(result).to be_falsey
      end
      it 'returns false (Black Knight vs White King => King unchecks)' do
        board.cells[[3, 2]].piece = b_knight
        board.cells[[4, 1]].piece = nil
        translated = [[4, 0], [4, 1]]
        result = game.checks_self?(translated, player_one, board)
        expect(result).to be_falsey
      end
    end
    context 'when given a move that does not uncheck the user' do
      it 'returns true (White Rook vs Black King => Still in Check)' do
        board.cells[[4, 3]].piece = w_rook
        board.cells[[4, 6]].piece = nil
        translated = [[4, 7], [4, 6]]
        result = game.checks_self?(translated, player_two, board)
        expect(result).to be_truthy
      end
      it 'returns true (Black Bishop vs White King => Still in Check)' do
        board.cells[[1, 3]].piece = b_bishop
        board.cells[[3, 1]].piece = nil
        translated = [[4, 0], [3, 1]]
        result = game.checks_self?(translated, player_one, board)
        expect(result).to be_truthy
      end
    end
  end

  describe '#checkmate?' do
    let(:blank_board) { Board.new }
    before do
      blank_board.cells.each { |_k, v| v.piece = nil }
    end
    context 'when simulating Anastasia Mate' do
      before do
        blank_board.cells[[6, 0]].piece = w_king
        blank_board.cells[[4, 2]].piece = w_rook
        blank_board.cells[[4, 6]].piece = w_knight
        blank_board.cells[[6, 6]].piece = b_pawn
        blank_board.cells[[7, 6]].piece = b_king
      end
      it 'returns false (one move before checkmate)' do
        result = game.checkmate?(player_one, blank_board)
        expect(result).to be_falsey
      end
      it 'returns true on checkmate' do
        blank_board.move_piece([[4, 2], [7, 2]])

        result = game.checkmate?(player_two, blank_board)
        expect(result).to be_truthy
      end
    end
    context 'when simulating Scholars Mate' do
      before do
        board.cells[[2, 3]].piece = w_bishop
        board.cells[[4, 3]].piece = w_pawn
        board.cells[[4, 4]].piece = b_pawn
        board.cells[[7, 4]].piece = w_queen
        board.cells[[2, 5]].piece = b_knight
        board.cells[[5, 5]].piece = b_knight
        board.cells[[3, 0]].piece = nil
        board.cells[[5, 0]].piece = nil
        board.cells[[4, 1]].piece = nil
        board.cells[[3, 0]].piece = nil
        board.cells[[4, 6]].piece = nil
        board.cells[[1, 7]].piece = nil
        board.cells[[6, 7]].piece = nil
      end
      it 'returns false (one move before checkmate)' do
        result = game.checkmate?(player_one, board)
        expect(result).to be_falsey
      end
      it 'returns true on checkmate' do
        board.move_piece([[7, 4], [5, 6]])
        result = game.checkmate?(player_two, board)
        expect(result).to be_truthy
      end
    end
    context 'when simulating Fools Mate' do
      before do
        board.cells[[5, 2]].piece = w_pawn
        board.cells[[6, 3]].piece = w_pawn
        board.cells[[4, 4]].piece = b_pawn
        board.cells[[5, 1]].piece = nil
        board.cells[[6, 1]].piece = nil
        board.cells[[4, 6]].piece = nil
      end
      it 'returns false (one move before checkmate)' do
        result = game.checkmate?(player_two, board)
        expect(result).to be_falsey
      end
      it 'returns true on checkmate' do
        board.move_piece([[3, 7], [7, 3]])
        result = game.checkmate?(player_one, board)
        expect(result).to be_truthy
      end
    end
    context 'when simulating Grecos Mate' do
      before do
        blank_board.cells[[2, 0]].piece = w_king
        blank_board.cells[[3, 0]].piece = w_rook
        blank_board.cells[[2, 3]].piece = w_bishop
        blank_board.cells[[6, 6]].piece = b_pawn
        blank_board.cells[[7, 7]].piece = b_king
      end
      it 'returns false (one move before checkmate)' do
        result = game.checkmate?(player_one, blank_board)
        expect(result).to be_falsey
      end
      it 'returns true on checkmate' do
        blank_board.move_piece([[3, 0], [7, 0]])

        result = game.checkmate?(player_two, blank_board)
        expect(result).to be_truthy
      end
    end
    context 'when simulating Arabian Mate' do
      before do
        blank_board.cells[[6, 0]].piece = w_king
        blank_board.cells[[5, 5]].piece = w_knight
        blank_board.cells[[1, 6]].piece = w_rook
        blank_board.cells[[7, 7]].piece = b_king
      end
      it 'returns false (one move before checkmate)' do
        result = game.checkmate?(player_one, blank_board)
        expect(result).to be_falsey
      end
      it 'returns true on checkmate' do
        blank_board.move_piece([[1, 6], [7, 6]])

        result = game.checkmate?(player_two, blank_board)
        expect(result).to be_truthy
      end
    end
    context 'when simulating Hook Mate' do
      before do
        blank_board.cells[[6, 0]].piece = w_king
        blank_board.cells[[5, 4]].piece = w_pawn
        blank_board.cells[[6, 5]].piece = w_knight
        blank_board.cells[[6, 6]].piece = b_pawn
        blank_board.cells[[7, 6]].piece = b_king
        blank_board.cells[[2, 7]].piece = w_rook
      end
      it 'returns false (one move before checkmate)' do
        result = game.checkmate?(player_one, blank_board)
        expect(result).to be_falsey
      end
      it 'returns true on checkmate' do
        blank_board.move_piece([[2, 7], [7, 7]])

        result = game.checkmate?(player_two, blank_board)
        expect(result).to be_truthy
      end
    end
  end

  describe '#stalemate' do
    let(:blank_board) { Board.new }
    before do
      blank_board.cells.each { |_k, v| v.piece = nil }
    end
    context 'when given a stalemate board' do
      before do
        w_king.moved = true
        b_king.moved = true
        blank_board.cells[[0, 7]].piece = w_king
        blank_board.cells[[5, 1]].piece = w_queen
        blank_board.cells[[7, 0]].piece = b_king
      end
      it 'returns true' do
        result = game.stalemate?(player_two, blank_board)
        expect(result).to be_truthy
      end
    end
    context 'when given a stalemate board (with unjumped pawns)' do
      before do
        board.cells[[2, 3]].piece = w_pawn
        board.cells[[7, 3]].piece = w_pawn
        board.cells[[7, 4]].piece = b_pawn
        board.cells[[4, 5]].piece = w_queen
        board.cells[[5, 5]].piece = b_pawn
        board.cells[[6, 5]].piece = b_king
        board.cells[[7, 5]].piece = b_rook
        board.cells[[7, 6]].piece = b_queen
        board.cells[[3, 0]].piece = nil
        board.cells[[2, 1]].piece = nil
        board.cells[[7, 1]].piece = nil
        board.cells[[0, 6]].piece = nil
        board.cells[[1, 6]].piece = nil
        board.cells[[2, 6]].piece = nil
        board.cells[[3, 6]].piece = nil
        board.cells[[5, 6]].piece = nil
        board.cells[[0, 7]].piece = nil
        board.cells[[1, 7]].piece = nil
        board.cells[[2, 7]].piece = nil
        board.cells[[3, 7]].piece = nil
        board.cells[[4, 7]].piece = nil
      end
      it 'returns true' do
        result = game.stalemate?(player_two, board)
        expect(result).to be_truthy
      end
    end
    context 'when given a capture-less stalemate' do
      before do
        board.cells[[3, 1]].piece = w_knight
        board.cells[[7, 1]].piece = w_queen
        board.cells[[1, 2]].piece = b_bishop
        board.cells[[4, 2]].piece = b_pawn
        board.cells[[5, 2]].piece = w_pawn
        board.cells[[6, 2]].piece = w_rook
        board.cells[[7, 2]].piece = w_pawn
        board.cells[[0, 3]].piece = w_pawn
        board.cells[[2, 3]].piece = w_pawn
        board.cells[[5, 3]].piece = b_pawn
        board.cells[[7, 3]].piece = b_queen
        board.cells[[0, 4]].piece = b_bishop
        board.cells[[2, 4]].piece = b_pawn
        board.cells[[3, 4]].piece = w_pawn
        board.cells[[3, 5]].piece = b_pawn
        board.cells[[5, 1]].piece = nil
        board.cells[[0, 0]].piece = nil
        board.cells[[1, 0]].piece = nil
        board.cells[[3, 0]].piece = nil
        board.cells[[0, 1]].piece = nil
        board.cells[[2, 1]].piece = nil
        board.cells[[2, 6]].piece = nil
        board.cells[[3, 6]].piece = nil
        board.cells[[4, 6]].piece = nil
        board.cells[[5, 6]].piece = nil
        board.cells[[2, 6]].piece = nil
        board.cells[[2, 7]].piece = nil
        board.cells[[3, 7]].piece = nil
        board.cells[[5, 7]].piece = nil
      end
      it 'returns true' do
        result = game.stalemate?(player_one, board)
        expect(result).to be_truthy
      end
    end
  end

  describe '#insufficient_material?' do
    let(:blank_board) { Board.new }
    before do
      blank_board.cells.each { |_k, v| v.piece = nil }
    end
    context 'there are only Kings' do
      before do
        blank_board.cells[[4, 0]].piece = w_king
        blank_board.cells[[4, 7]].piece = b_king
      end
      it 'returns true' do
        result = game.insufficient_material?(blank_board)
        expect(result).to be_truthy
      end
    end
    context 'when the board contains enough material' do
      it 'returns false' do
        result = game.insufficient_material?(board)
        expect(result).to be_falsey
      end
    end
    context 'there are only Kings and 1 Knight' do
      before do
        blank_board.cells[[4, 0]].piece = w_king
        blank_board.cells[[4, 7]].piece = b_king
        blank_board.cells[[2, 3]].piece = w_knight
      end
      it 'returns true' do
        result = game.insufficient_material?(blank_board)
        expect(result).to be_truthy
      end
    end
    context 'when the board contains more than 1 knight and kings' do
      before do
        blank_board.cells[[4, 0]].piece = w_king
        blank_board.cells[[4, 7]].piece = b_king
        blank_board.cells[[2, 3]].piece = w_knight
        blank_board.cells[[1, 7]].piece = b_knight
      end
      it 'returns false' do
        result = game.insufficient_material?(blank_board)
        expect(result).to be_falsey
      end
    end
    context 'there are only Kings and same-colored-square Bishops' do
      before do
        blank_board.cells[[4, 0]].piece = w_king
        blank_board.cells[[4, 7]].piece = b_king
        blank_board.cells[[2, 0]].piece = w_bishop
        blank_board.cells[[5, 7]].piece = b_bishop
      end
      it 'returns true' do
        result = game.insufficient_material?(blank_board)
        expect(result).to be_truthy
      end
    end
    context 'when the board contain 2 bishops of different colored squares and 2 Kings' do
      before do
        blank_board.cells[[4, 0]].piece = w_king
        blank_board.cells[[4, 7]].piece = b_king
        blank_board.cells[[2, 0]].piece = w_bishop
        blank_board.cells[[2, 7]].piece = b_bishop
      end
      it 'returns false' do
        result = game.insufficient_material?(blank_board)
        expect(result).to be_falsey
      end
    end
  end

  describe '#game_over?' do
    let(:blank_board) { Board.new }
    before do
      blank_board.cells.each { |_k, v| v.piece = nil }
    end
    context 'when given a stalemate board' do
      before do
        w_king.moved = true
        b_king.moved = true
        blank_board.cells[[0, 7]].piece = w_king
        blank_board.cells[[5, 1]].piece = w_queen
        blank_board.cells[[7, 0]].piece = b_king
      end
      it 'returns true' do
        game.instance_variable_set(:@current, player_two)
        result = game.game_over?(blank_board)
        expect(result).to be_truthy
      end
    end
    context 'when given a checkmate board' do
      before do
        blank_board.cells[[6, 0]].piece = w_king
        blank_board.cells[[7, 2]].piece = w_rook
        blank_board.cells[[4, 6]].piece = w_knight
        blank_board.cells[[6, 6]].piece = b_pawn
        blank_board.cells[[7, 6]].piece = b_king
      end
      it 'it returns true' do
        game.instance_variable_set(:@current, player_two)
        result = game.game_over?(blank_board)
        expect(result).to be_truthy
      end
    end
    context 'when given a neutral board' do
      before do
        blank_board.cells[[6, 0]].piece = w_king
        blank_board.cells[[4, 2]].piece = w_rook
        blank_board.cells[[4, 6]].piece = w_knight
        blank_board.cells[[6, 6]].piece = b_pawn
        blank_board.cells[[7, 6]].piece = b_king
      end
      it 'it returns false' do
        game.instance_variable_set(:@current, player_one)
        result = game.game_over?(blank_board)
        expect(result).to be_falsey
      end
    end
    context 'when given an initialized board' do
      it 'it returns false' do
        game.instance_variable_set(:@current, player_one)
        result = game.game_over?(board)
        expect(result).to be_falsey
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
# rspec --format documentation spec/gameovers_spec.rb
