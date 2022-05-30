# frozen_string_literal: true

# rspec spec/board_spec/board_spec.rb
# rspec --format documentation spec/board_spec/board_spec.rb

require_relative '../../lib/board/board'
require_relative '../../lib/board/cell'

# piece folders
require_relative '../../lib/pieces/rook'
require_relative '../../lib/pieces/knight'
require_relative '../../lib/pieces/bishop'
require_relative '../../lib/pieces/queen'
require_relative '../../lib/pieces/king'
require_relative '../../lib/pieces/pawn'

require 'pry-byebug'

describe Board do
  subject(:board) { described_class.new }
  describe '#create_board' do
    context 'when method is called' do
      it 'creates a hash of 64 keys' do
        expect(board.cells.length).to eq(64)
      end
    end
  end
end
