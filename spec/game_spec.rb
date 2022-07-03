# frozen_string_literal: true

# rspec --format documentation spec/game_spec.rb

require_relative '../lib/library'

# rubocop:disable Metrics/BlockLength

describe Game do
  subject(:game) { described_class.new }

  let(:board) { Board.new }

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

  describe '#create_player' do
    context 'when a new player is created' do
      before do
        allow(game).to receive(:display_name).and_return('Stranger')
      end
      it 'creates an object of the player class' do
        player = game.create_player(1, :light_white)
        expect(player).to be_a(Player)
      end
      it 'has a name' do
        player = game.create_player(1, :light_white)
        expect(player.name).to eq('Stranger')
      end
      it 'has a color' do
        player = game.create_player(1, :light_white)
        expect(player.color).to eq(:light_white)
      end
    end
  end

  describe '#turn_player' do
    before do
      game.instance_variable_set(:@player_one, player_one)
      game.instance_variable_set(:@player_two, player_two)
    end
    context 'when round is odd' do
      it 'returns player two' do
        game.instance_variable_set(:@round, 1)
        result = game.turn_player
        expect(result).to eq(player_one)
      end
    end
    context 'when round is even' do
      it 'returns player two' do
        game.instance_variable_set(:@round, 2)
        result = game.turn_player
        expect(result).to eq(player_two)
      end
    end
  end

  describe '#translate' do
    context 'when given a valid inputs' do
      it 'returns the correct output (a2a3 => [[0, 1], [0, 2]])' do
        input = 'a2a3'
        result = game.translate(input)
        expect(result).to eq([[0, 1], [0, 2]])
      end
      it 'returns the correct output (g8f6 => [[6, 7], [5, 5]])' do
        input = 'g8f6'
        result = game.translate(input)
        expect(result).to eq([[6, 7], [5, 5]])
      end
      it 'returns the correct output (d1g5 => [[3, 0], [6, 4]])' do
        input = 'd1g4'
        result = game.translate(input)
        expect(result).to eq([[3, 0], [6, 3]])
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
        result = game.game_over?(player_two, blank_board)
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
        result = game.game_over?(player_two, blank_board)
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
        result = game.game_over?(player_one, blank_board)
        expect(result).to be_falsey
      end
    end
    context 'when given an initialized board' do
      it 'it returns false' do
        result = game.game_over?(player_one, board)
        expect(result).to be_falsey
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
# rspec --format documentation spec/game_spec.rb
