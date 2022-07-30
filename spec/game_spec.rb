# frozen_string_literal: true

# rspec --format documentation spec/game_spec.rb

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

  describe '#turn_player' do
    before do
      game.instance_variable_set(:@player_one, player_one)
      game.instance_variable_set(:@player_two, player_two)
    end
    context 'when current player is' do
      it 'returns player two' do
        game.instance_variable_set(:@current, player_two)
        result = game.turn_player
        expect(result).to eq(player_one)
      end
    end
    context 'when round is even' do
      it 'returns player two' do
        game.instance_variable_set(:@current, player_one)
        result = game.turn_player
        expect(result).to eq(player_two)
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
        allow(game).to receive(:display_promotion).and_return('r')
        game.promote(board, land)
        piece = board.cells[land].piece
        expect(piece).to be_a(Rook)
      end
      it 'converts pawn to Bishop' do
        allow(game).to receive(:display_promotion).and_return('b')
        game.promote(board, land)
        piece = board.cells[land].piece
        expect(piece).to be_a(Bishop)
      end
      it 'converts pawn to Knight' do
        allow(game).to receive(:display_promotion).and_return('k')
        game.promote(board, land)
        piece = board.cells[land].piece
        expect(piece).to be_a(Knight)
      end
      it 'converts pawn to Queen' do
        allow(game).to receive(:display_promotion).and_return('q')
        game.promote(board, land)
        piece = board.cells[land].piece
        expect(piece).to be_a(Queen)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
# rspec --format documentation spec/game_spec.rb
