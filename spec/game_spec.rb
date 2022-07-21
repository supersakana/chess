# frozen_string_literal: true

# rspec --format documentation spec/game_spec.rb

require_relative '../lib/library'

require 'pry-byebug'

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

  describe '#game_over?' do
    let(:blank_board) { Board.new }
    before do
      blank_board.cells.each { |_k, v| v.piece = nil }
    end
    context 'when given a stalemate board' do
      before do
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
# rspec --format documentation spec/game_spec.rb
