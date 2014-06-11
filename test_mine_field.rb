require 'simplecov'
require 'turn/autorun'

SimpleCov.start do
  add_filter 'vendor'
end

require './game'

describe Grid do

  it "must know the meaning of life" do
    life = 42
    life.must_equal 42
  end
end