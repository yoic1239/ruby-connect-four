# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/board'

# Connet Four game
class Game
  def initialize(board = Board.new)
    @player1 = Player.new('Player 1', "\u26aa")
    @player2 = Player.new('Player 2', "\u26ab")
    @board = board
  end

  def play
  end

  def player_input
    loop do
      user_input = gets.chomp
      input_column = user_input.to_i - 1 if user_input.between?('1', '7')
      return input_column if input_column && !@board.full_column?(input_column)

      if input_column
        puts "Column #{user_input} is full. Please enter a column which is not full."
      else
        puts 'Invalid input! You should input a valid column.'
      end
    end
  end
end
