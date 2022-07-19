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
        translated = [[0, 1], [0, 2]]
        board.move_piece(translated)
        expect(board.cells[[0, 1]].empty?).to be_truthy
      end
      it 'occupies the landing cell with the selected piece' do
        translated = [[0, 1], [0, 2]]
        selected = board.cells[[0, 1]].piece
        landing = board.cells[[0, 2]]
        board.move_piece(translated)
        expect(landing.piece).to eq(selected)
      end
      it 'captures piece if landing contains opponent piece' do
        board.cells[[0, 2]].piece = b_pawn
        translated = [[1, 1], [0, 2]]
        board.move_piece(translated)
        expect(board.grave[:player_one]).to eq(['♟'])
      end
    end
    context 'when the pawn gets inspected' do
      it 'pawn jump is removed after first move is made' do
        translated = [[0, 1], [0, 3]]
        landing = board.cells[[0, 3]]
        board.move_piece(translated)
        pawn_shifts = landing.piece_shifts
        expect(pawn_shifts).to eq([[0, 1], [1, 1], [-1, 1]])
      end
      it 'pawn @jumped is true if the pawn made a jump move' do
        translated = [[0, 1], [0, 3]]
        board.move_piece(translated)
        pawn = board.cells[[0, 3]].piece
        result = pawn.jumped
        expect(result).to be_truthy
      end
      it 'pawn @jumped remains false if jump is not made' do
        translated = [[0, 1], [0, 2]]
        board.move_piece(translated)
        pawn = board.cells[[0, 2]].piece
        result = pawn.jumped
        expect(result).to be_falsey
      end
      it 'pawn @jumped remains flase if in jump position but did not jump' do
        board.cells[[0, 2]].piece = w_pawn
        board.cells[[0, 1]].piece = nil
        translated = [[0, 2], [0, 3]]
        board.move_piece(translated)
        pawn = board.cells[[0, 3]].piece
        result = pawn.jumped
        expect(result).to be_falsey
      end
      it 'pawn @jumped can be true for black pawns too' do
        translated = [[0, 6], [0, 4]]
        board.move_piece(translated)
        pawn = board.cells[[0, 4]].piece
        result = pawn.jumped
        expect(result).to be_truthy
      end
    end
    context 'when an en passant is enabled' do
      before do
        b_pawn.instance_variable_set(:@jumped, true)
        w_pawn.instance_variable_set(:@ep_enabled, true)
        board.cells[[4, 4]].piece = w_pawn
        board.cells[[3, 4]].piece = b_pawn
        board.cells[[4, 1]].piece = nil
        board.cells[[3, 6]].piece = nil
      end
      it 'disables the pawns en passant (ep_enabled = nil) if not usec' do
        translated = [[6, 0], [7, 2]]
        board.move_piece(translated)
        result = board.cells[[4, 4]].piece.ep_enabled
        expect(result).to be_nil
      end
      it 'captures the foe piece correctly' do
        translated = [[4, 4], [3, 5]]
        board.move_piece(translated)
        expect(board.grave[:player_one]).to eq(['♟'])
      end
      it 'moves properly if an ep move was not made' do
        translated = [[4, 4], [4, 5]]
        board.move_piece(translated)
        land = board.cells[[4, 5]].piece
        expect(land).to eq(w_pawn)
      end
    end
  end
  describe '#promote' do
    context 'when given a valid input to promote' do
      before do
        board.cells[[0, 7]].piece = w_pawn
      end
      land = [0, 7]
      it 'converts pawn to Rook' do
        allow(board).to receive(:display_promotion).and_return('r')
        board.promote(land)
        piece = board.cells[land].piece
        expect(piece).to be_a(Rook)
      end
      it 'converts pawn to Bishop' do
        allow(board).to receive(:display_promotion).and_return('b')
        board.promote(land)
        piece = board.cells[land].piece
        expect(piece).to be_a(Bishop)
      end
      it 'converts pawn to Knight' do
        allow(board).to receive(:display_promotion).and_return('k')
        board.promote(land)
        piece = board.cells[land].piece
        expect(piece).to be_a(Knight)
      end
      it 'converts pawn to Queen' do
        allow(board).to receive(:display_promotion).and_return('q')
        board.promote(land)
        piece = board.cells[land].piece
        expect(piece).to be_a(Queen)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
# rspec --format documentation spec/board_spec.rb
