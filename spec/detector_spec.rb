# frozen_string_literal: true

# rspec --format documentation spec/board_spec.rb

require_relative '../lib/library'

require 'pry-byebug'

describe Board do
  subject(:detect) { described_class.new }
end
