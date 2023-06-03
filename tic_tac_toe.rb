#!/usr/bin/env ruby

require 'pry-byebug'

class Board
  WIN_CONDITIONS = [[1, 2, 3],
                    [4, 5, 6],
                    [7, 8, 9],
                    [1, 4, 7],
                    [2, 5, 8],
                    [3, 6, 9],
                    [1, 5, 9],
                    [3, 5, 7]]

  attr_reader :spaces

  def initialize
    @spaces = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def win_conditions
    WIN_CONDITIONS
  end

  def draw_board
    puts "\e[H\e[2J"
    board = " #{spaces[0]} | #{spaces[1]} | #{spaces[2]} ",
            '---+---+---',
            " #{spaces[3]} | #{spaces[4]} | #{spaces[5]} ",
            '---+---+---',
            " #{spaces[6]} | #{spaces[7]} | #{spaces[8]} "
    puts board
  end
end

class Player
  @@total_turns = 0
  def self.total_turns
    @@total_turns
  end

  def self.tie
    puts "It's a tie!"
    exit
  end

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
    @@total_turns += 1
  end

  def check_win
    board.win_conditions.map { |win_condition| (win_condition & played_positions).length == 3 }.include? true
  end

  def win
    puts "#{symb} wins!"
    exit
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
    board.draw_board
  end
end

class ComputerPlayer < Player
  def play_turn
    selected_space = ''
    loop do
      selected_space = board.spaces.sample
      break unless selected_space.is_a? String
    end
    place_symb(selected_space)
    board.draw_board
  end
end

def choose_player(name, symb, board)
  puts "#{name} (h)uman or (c)omputer?"
  loop do
    p_choice = gets.chomp
    case p_choice
    when 'h' then return HumanPlayer.new(symb, board)
    when 'c' then return ComputerPlayer.new(symb, board)
    else puts 'Invalid option, please choose (h)uman or (c)omputer'
    end
  end
end

def play_game
  board = Board.new
  board.draw_board

  player1 = choose_player('Player 1', 'X', board)
  player2 = choose_player('Player 2', 'O', board)

  loop do
    player1.play_turn
    player1.check_win and player1.win
    Player.tie if Player.total_turns == 9
    player2.play_turn
    player2.check_win and player2.win
  end
end

play_game