# frozen_string_literal: true

require 'pry-byebug'

# contains methods that detect a valid castling move
module Castling
  # only possible if neither the king nor rook have moved
  # there must not be any pieces between the king and rook
  # the king must not be in check
  # the square the king lands on must not be under attack
  # you can not castle through check (OPTIONAL)
end
