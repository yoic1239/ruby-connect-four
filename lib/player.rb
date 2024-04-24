# frozen_string_literal: true

# Assign player's name and piece in the Connect Four game
class Player
  attr_reader :name, :piece

  def initialize(name, piece)
    @name = name
    @piece = piece
  end

  def show_piece
    puts "Hi #{@name}, your piece is #{@piece}"
  end
end
