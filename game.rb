#!/usr/bin/env ruby

class InvalidInput < Exception
end

class Game
  attr_accessor :rows, :columns
  def initialize file_name=""
    raise InvalidInput unless File.exist? file_name
    input    = File.read(file_name).split
    @rows    = input.count
    @columns = input.first.length
  end
end

class Grid

end

if __FILE__ == $0
  # this will only run if the script was the main, not load'd or require'd
  puts 42
end
