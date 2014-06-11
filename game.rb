#!/usr/bin/env ruby

class InvalidInput < Exception
end

class Game
  attr_accessor :rows, :columns, :field

  def initialize file_name=""
    raise InvalidInput unless File.exist? file_name
    input    = File.read(file_name).split
    @rows    = input.count
    @columns = input.first.length
    @field   = field_from_file input
    evaluate_field!
  end

  def display
    output = ""
    @field.each do |row|
      output << row.join + '\n'
    end
    output
  end

  private
    def field_from_file input
      field = []
      input.each do |row|
        field << row.split(//)
      end
      field
    end

    def evaluate_field!
      each_cell_with_index(@field) do |cell, row_idx, col_idx|
        @field[row_idx][col_idx] = number_mine_neighbors cell
      end
    end

    def each_cell_with_index(field)
      field.each_with_index do |row, row_idx|
        field.each_with_index do |cell, col_idx|
          yield cell, row_idx, col_idx
        end
      end
    end

    def number_mine_neighbors cell
      0
    end
end

class Grid

end

if __FILE__ == $0
  # this will only run if the script was the main, not load'd or require'd
  puts 42
end
