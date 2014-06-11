#!/usr/bin/env bundle exec ruby

require 'colorize'

class InvalidInput < Exception
end

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
    output.gsub(MINE_STR, MINE_STR.red)
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
        @field[row_idx][col_idx] = count_nearby_mines(row_idx, col_idx)
      end
    end

    def each_cell_with_index
      @field.each_with_index do |row, row_idx|
        row.each_with_index do |cell, col_idx|
          yield cell, row_idx, col_idx
        end
      end
    end

    def count_nearby_mines row_idx, col_idx
      neighbors_of(row_idx, col_idx).select{|cell| is_mine?(cell)}.count
    end

    def neighbors_of row_idx, col_idx
      neighbors = []
      each_adjacent(row_idx) do |row|
        each_adjacent(col_idx) do |col|
          next if row == row_idx and col == col_idx
          next unless within_field?(row, col)
          neighbors << @field[row][col]
        end
      end
      neighbors
    end

    def each_adjacent idx
      [idx - 1, idx, idx + 1].each do |index|
        yield index
      end
    end

    def within_field?(row, col)
      row >= 0 && row < @rows && col >= 0 && col < @columns
    end

    def is_mine? cell
      cell == MINE_STR
    end
end

if __FILE__ == $0
  # this will only run if the script was the main, not load'd or require'd
  puts Game.new(ARGV[0]).display
end
