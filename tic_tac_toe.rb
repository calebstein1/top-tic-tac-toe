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
  attr_reader :symb, :board

  def initialize(symb, board)
    @played_positions = []
    @symb = symb
    @board = board
  end

  def place_symb(selected_space)
    board.spaces[selected_space - 1] = symb
    played_positions.push(selected_space)
    board.draw_board
  end
end

class HumanPlayer < Player
  def play_turn
    selected_space = ''
    puts 'Choose an available space:'
    loop do
      selected_space = gets.chomp
      break if board.spaces[selected_space.to_i - 1] == selected_space.to_i

      puts "#{selected_space} is not a valid or available space, please choose a valid or available space:"
    end
    place_symb(selected_space.to_i)
  end
end

board = Board.new
board.draw_board

human = HumanPlayer.new('x', board)
human.play_turn
