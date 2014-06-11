#!/usr/bin/env ruby

class InvalidInput < Exception
end

require 'debugger'
class Game
  MINE_STR = '@'

  attr_accessor :rows, :columns, :field

  def initialize file_name=""
    raise InvalidInput unless File.exist? file_name
    input    = File.read(file_name).split
    @rows    = input.count
    @columns = input.first.length
    @field   = field_from_file input
    mine_sweep!
  end

  def display
    output = ""
    @field.each do |row|
      output << row.join + "\n"
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

    def mine_sweep!
      each_cell_with_index do |cell, row_idx, col_idx|
        next if is_mine? cell
        @field[row_idx][col_idx] = number_mine_neighbors(row_idx, col_idx)
      end
    end

    def each_cell_with_index
      @field.each_with_index do |row, row_idx|
        row.each_with_index do |cell, col_idx|
          yield cell, row_idx, col_idx
        end
      end
    end

    def number_mine_neighbors row_idx, col_idx
      neighbors_of(row_idx, col_idx).select{|cell| is_mine?(cell)}.count
    end

    def neighbors_of row_idx, col_idx
      neighbors = []
      [row_idx - 1, row_idx, row_idx + 1].each do |row|
        [col_idx - 1, col_idx, col_idx + 1].each do |col|
          next if row == row_idx and col == col_idx
          next unless within_field?(row, col)
          neighbors << @field[row][col]
        end
      end
      neighbors
    end

    def within_field?(row, col)
      row >= 0 && row < @rows && col >= 0 && col < @columns
    end

    def is_mine? cell
      cell == MINE_STR
    end
end

class Grid

end

if __FILE__ == $0
  # this will only run if the script was the main, not load'd or require'd
  puts 42
end
