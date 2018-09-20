require_relative 'player'
require_relative 'board'
require_relative 'computer'
require 'byebug'

class BattleshipGame
  attr_reader :board, :player, :player2, :board2,
              :current_player, :player, :boards

  def initialize(player=HumanPlayer.new, board=Board.new, player2=nil)
    @player = player
    @board = board
    @player2 = player2
    @board2 = Board.new
    @curr = 0
    @players = [@player, @player2]
    @boards = [@board, @board2]
  end

  def switch_player
    @curr = (curr == 0 ) ? 1 : 0
  end

  def attack(pos)
    val = false
    val = true if @board[pos] == :s
    @board[pos] = :x
    val
  end

  def count
    @board.count
  end

  def game_over?
    @board.won? || @board2.won?
  end

  def play_turn
    pos = [0,0]

    loop do
      pos = @player.get_play
      if @board.in_range?(pos)
        if @board[pos] == :x
          puts "Position has already been fired at"
          next
        else
          break
        end
      else
        puts "Invalid location"
      end
    end
    attack(pos)
  end

  def play
    @board.populate_grid
    @board2.populate_grid
    while !game_over?
      @board.display
      puts "\n\nThere are #{self.count} ships remaining\n\n"
      if play_turn
        puts "\n\nYou sunk my battleship!\n\n\n"
      else
        puts "\n\nMiss!\n\n"
      end
    end
    puts "\nGame Over!\n\n"
    @board.display
  end
end

if __FILE__ == $PROGRAM_NAME
  ans = ""
  puts "\n\nWelcome to Battleship!\n\n"
  vals = ["1", "2", "C", "c"]
  loop do
    puts "1 player(1), 2 players(2), vs Computer(c) or Computer Simulation(C)?"
    ans = gets.chomp.strip
    break if vals.include?(ans)
    puts"Invalid Option"
  end
  case ans
  when "1"
    game = BattleshipGame.new
  when "2"
    game = BattleshipGame.new(HumanPlayer.new, Board.new, HumanPlayer.new)
  when "c"
    game = BattleshipGame.new(HumanPlayer.new, Board.new, ComputerPlayer.new)
  when "C"
    game = BattleshipGame.new(ComputerPlayer.new)
  end
  game.play
end
