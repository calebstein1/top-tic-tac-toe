#!/usr/bin/env ruby

require 'pry-byebug'

class Board
  attr_reader :spaces

  def initialize
    @spaces = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def draw_board
    board = " #{spaces[0]} | #{spaces[1]} | #{spaces[2]} ",
            '---+---+---',
            " #{spaces[3]} | #{spaces[4]} | #{spaces[5]} ",
            '---+---+---',
            " #{spaces[6]} | #{spaces[7]} | #{spaces[8]} "
    puts board
  end
end

class Player
  attr_accessor :played_positions
  attr_reader :symb

  def initialize(symb)
    @played_positions = []
    @symb = symb
  end
end

class HumanPlayer < Player
  def play_turn
    puts 'Choose an available space:'
    loop do
      selected_space = gets.chomp
      #break if board.open_spaces.include?(selected_space)

      puts "#{selected_space} is not a valid or available space, please choose a valid or available space:"
    end
  end
end

board = Board.new

board.draw_board

binding.pry

human = HumanPlayer.new('x')

human.play_turn