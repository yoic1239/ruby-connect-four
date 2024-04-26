# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/board'

# Connet Four game
class Game
  def initialize(board = Board.new)
    @player1 = Player.new('Player 1', "\u26aa")
    @player2 = Player.new('Player 2', "\u26ab")
    @board = board
    @curr_player = @player1
  end

  def play
    introduction
    drop_piece
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

  def drop_piece
    puts "\e[0;34m#{@curr_player.name}\e[0m's turn"
    puts 'Which column would you like to put your piece?'
    selected_column = player_input
    @board.update_board(selected_column, @curr_player.piece)
  end

  def win?
    @board.four_consecutive_in_row? || @board.four_consecutive_in_column? ||
      @board.four_consecutive_in_left_diagonal? || @board.four_consecutive_in_right_diagonal?
  end

  def game_over?
    win? || @board.full?
  end

  def change_player
    @curr_player = @curr_player == @player2 ? @player1 : @player2
  end

  def introduction
    puts <<~HEREDOC

      Welcome to the Connect Four game!

      1. Take turns to drop pieces into the cage.
      2. You win once you get 4 of your pieces consecutively in a row, column, or along a diagonal.

    HEREDOC
  end
end
