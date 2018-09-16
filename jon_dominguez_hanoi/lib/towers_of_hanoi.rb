# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp.html) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bashd
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.

require 'byebug'
class TowersOfHanoi

  attr_reader :towers

  def initialize
    reset(3)
  end

  def reset(discs)
    @towers = Array.new(3){Array.new}
    @towers[0] = discs.downto(1).to_a
    @discs = @towers[0].length
  end

  def move(from, to)
    if valid_move?(from, to)
      @towers[to].push(@towers[from].pop)
    else
      puts "Invalid move! Try again!"
    end
  end

  def valid_move?(from, to)
    if @towers[from].empty?
      return false
    else
      last = @towers[to].last || @discs + 1
      return false if @towers[from].last > last
    end
    true
  end

  def won?
    final = (1..@discs).to_a.reverse
    if (@towers[1] == final && @towers[0].empty? && @towers[2].empty?) ||
       (@towers[2] == final && @towers[0].empty? && @towers[1].empty?)
      return true
    end
    false
  end

  def get_answer(string)
    puts "Which tower do you want to #{string}? (1-3)"
    ans = gets.chomp
    if !["1", "2", "3"].include?(ans)
      return -1
    else
      ans
    end
  end

  def render
    string = ""
    (0...@discs).to_a.reverse.each do |j| #0-2
      string = ""
      (0...@towers.length).each do |i| #0-2
        string = ""
        if !@towers[i][j] # 0,0
          string = " "*(@discs+1) + "|" + " "*(@discs+1)
        else
          string += " "*(@discs-@towers[i][j]) + "(" + "="*@towers[i][j] + "|" +
                    "="*@towers[i][j] + ")" + " "*(@discs-@towers[i][j])
        end
        print string
      end
      puts "\n"
    end
    puts ("-"*string.length)*@towers.length
  end

  def play
    resp = ""
    loop do
      puts "Your goal is to move the tower from the first pole to another." +
        " You may not place a bigger piece on a smaller piece. The current " +
        "tower size is 3. Would you like to change it? (Y/N)"
      resp = gets.chomp
      valids = ["Y", "N", "y", "n"]
      break if valids.include?(resp)
      puts "Invalid answer"
    end
    loop do
      if resp == "Y" || resp == "y"
        puts "What size tower would you like? (3-7)"
        size = gets.chomp
        if ["3","4","5","6","7"].include?(size)
          reset(size.to_i)
          break
        end
        puts "Invalid size! Try again"
      else
        break
      end
    end
    loop do
      render
      if won?
        puts "Winner!"
        self.reset(@discs)
        break
      end
      from = get_answer("remove from").to_i - 1
      to = get_answer("move to").to_i - 1
      if from < 0 || to < 0
        puts "Invalid option! Try again!"
        next
      end
      move(from, to)
    end
  end

end
