# frozen_string_literal: true

# Game board in the Connect Four game
class Board
  def initialize
    @board = Array.new(6) { Array.new(7) }
  end

  def display
    @board.reverse_each do |row|
      row.each do |col|
        print col ? "|#{col}" : '|  '
      end
      puts '|'
    end
  end

  def full_column?(column)
  end
end
