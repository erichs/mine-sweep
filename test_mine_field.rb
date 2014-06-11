require 'simplecov'
require 'turn/autorun'
require 'colorize'

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
    game.display.uncolorize.scan(/0/).count.must_equal 16
  end

  it "detects mines in a top row" do
    game = Game.new('examples/1_by_3_has_1_mine.txt')
    output = game.display
    output.uncolorize.scan(/1/).count.must_equal 1
  end

  it "detects mines in two dimensions" do
    game = Game.new('examples/4_by_4_has_2_mines.txt')
    game.display.uncolorize.scan(/2/).count.must_equal 2
  end
end
