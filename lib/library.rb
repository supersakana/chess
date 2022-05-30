# frozen_string_literal: true

# general files
require_relative 'player'
require_relative 'display'
require_relative 'game'

# board files
require_relative 'board/board'
require_relative 'board/cell'

# piece files
require_relative 'pieces/piece_factory'
require_relative 'pieces/rook'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/pawn'

# gems
require 'colorize'
