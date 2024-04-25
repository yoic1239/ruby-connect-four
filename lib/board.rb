# frozen_string_literal: true

# Game board in the Connect Four game
class Board
  def initialize(board = Array.new(6) { Array.new(7) })
    @board = board
  end

  def display
    @board.reverse_each do |row|
      row.each do |col|
        print col ? "|#{col}" : '|  '
      end
      puts '|'
    end
    puts "\e[1;32m 1  2  3  4  5  6  7\e[0m"
  end

  def full_column?(column)
    @board.all? { |row| row[column] }
  end
end
