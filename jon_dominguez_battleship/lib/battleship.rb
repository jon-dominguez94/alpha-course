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
    @curr = (@curr == 0 ) ? 1 : 0
  end

  def attack(pos)
    val = false
    val = true if @boards[@curr][pos] == :s
    @boards[@curr][pos] = :x
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
      pos = @players[@curr].get_play
      if @boards[@curr].in_range?(pos)
        if @boards[@curr][pos] == :x || @boards[@curr][pos] == :o
          puts "Position has already been fired at"
          next
        else
          break
        end
      else
        puts "Invalid location"
      end
    end
    puts %x{clear}
    if attack(pos)
      return true
    else
      @boards[@curr][pos] = :o
      return false
    end
  end

  def self.get_answer(string, vals)
    ans = ""
    loop do
      puts string
      ans = gets.chomp.strip
      break if vals.include?(ans)
      puts"Invalid Option"
    end
    puts %x{clear}
    ans
  end

  def play
    num_ships = rand(25) + 5
    if @player2 && @player2.name != "CPU"
      ans = BattleshipGame.get_answer("Random 1-Tile Ships(r) or Place Your Own(o)?",
          ["r", "o"])
      case ans
      when "r"
        @boards.each {|board| board.populate_grid(num_ships)}
      when "o"
        puts "Player 1, place your ships\n\n"
        @board2.place_ships
        puts "Player 2, place your ships\n\n"
        @board.place_ships

      end
    else
      @boards.each {|board| board.populate_grid(num_ships)}
    end

    while !game_over?
      puts "#{@players[@curr].name}'s turn!\n\n"
      @boards[@curr].display(true)
      puts "\n\nThere are #{@boards[@curr].count} live ship tiles remaining\n\n"
      puts play_turn ? "#{@players[@curr].name} Hit!\n\n\n" :
                        "#{@players[@curr].name} Missed!\n\n\n"
      switch_player if @player2
    end
    switch_player if @player2
    puts "\nGame Over!\n\n"
    puts "#{@players[@curr].name} Won!\n\n"
    puts "Their ships:"
    @boards[@curr].display
    if @player2
      switch_player
      puts "\n\nYour ships:"
      @boards[@curr].display
    end

  end
end

if __FILE__ == $PROGRAM_NAME
  puts "\n\nWelcome to Battleship!\n\n"
  string = "1 player(1), 2 players(2), vs Computer(c) or Computer Simulation(C)?"
  ans = BattleshipGame.get_answer(string, ["1", "2", "C", "c"])
  case ans
  when "1"
    game = BattleshipGame.new(HumanPlayer.new("Player 1"))
  when "2"
    game = BattleshipGame.new(HumanPlayer.new("Player 1"),
            Board.new, HumanPlayer.new("Player 2"))
  when "c"
    game = BattleshipGame.new(HumanPlayer.new("Player 1"), Board.new, ComputerPlayer.new)
  when "C"
    game = BattleshipGame.new(ComputerPlayer.new)
  end
  game.play
end
