require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

require 'byebug'
class Game

  attr_accessor :board, :current_player

  def initialize(player1, player2)
    @player1 = player1
    @current_player = player1
    @player2 = player2
    @board = Board.new
  end

  def play_turn
    #debugger
    # strange TypeErrors in this function. Had to simplify and make workarounds
    # in other methods
    move = @current_player.get_move
    result = @board.place_mark(move, @current_player.mark)
    switch_players! if result

  end

  def switch_players!
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

  def play
    puts "Let's play Tic-Tac-Toe!"
    @board.display
    while !@board.over?
      play_turn
      @board.display
      puts "\n" + "+"*(board.grid.length*3 + board.grid.length - 1) + "\n\n"
    end
    puts "Results"
    @board.display
  end
end


if __FILE__ == $PROGRAM_NAME
  human = HumanPlayer.new("Jon")
  human.mark = :X
  comp = ComputerPlayer.new("CPU")
  comp.mark = :O
  game = Game.new(human, comp)
  comp.display(game.board)
  game.play
end
