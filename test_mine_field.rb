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

  it "auto sizes based off input file" do
    game = Game.new('examples/4_by_5.txt')
    n = game.rows
    m = game.columns
    n.must_equal 4
    m.must_equal 5
  end

  it "displays zeroes for blank input" do
    game = Game.new('examples/4_by_4_blank.txt')
    game.display.scan(/0/).count.must_equal 16
  end

  it "detects mines in a top row" do
    game = Game.new('examples/1_by_3_has_1_mine.txt')
    output = game.display
    puts output
    output.scan(/1/).count.must_equal 1
  end
end

describe Grid do

  it "must know the meaning of life" do
    life = 42
    life.must_equal 42
  end
end