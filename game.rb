#!/usr/bin/env ruby

class InvalidInput < Exception
end

class Game
  def initialize file_name=""
    raise InvalidInput unless File.exist? file_name

  end
end

class Grid

end

if __FILE__ == $0
  # this will only run if the script was the main, not load'd or require'd
  puts 42
end
