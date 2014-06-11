require 'simplecov'
require 'turn/autorun'

SimpleCov.start do
  add_filter 'vendor'
end

require './game'

describe Game do
  it "fails if no input file is given" do
    proc { Game.new() }.must_raise InvalidInput
  end
end

describe Grid do

  it "must know the meaning of life" do
    life = 42
    life.must_equal 42
  end
end