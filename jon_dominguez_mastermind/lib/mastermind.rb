require 'byebug'

class Code

  attr_reader :pegs

  PEGS = {
    "R"=>"Red",
    "G"=>"Green",
    "B"=>"Blue",
    "Y"=>"Yellow",
    "O"=>"Orange",
    "P"=>"Purple"
  }

  def initialize(pegs)
    @pegs = pegs
  end

  def self.parse(string)
    result = string.chars
    if result.all? {|ch| PEGS.keys.include?(ch.upcase)} && result.length == 4
      Code.new(result)
    else
      raise "Invalid Code"
    end
  end

  def self.random
    random_pegs = []
    4.times { random_pegs << PEGS.keys.sample }
    Code.new(random_pegs)
  end

  def [](idx)
    @pegs[idx]
  end

  def exact_matches(code2)
    count = 0
    @pegs.each_with_index do |el, i|
      count += 1 if code2.pegs[i].downcase == el.downcase
    end
    count
  end

  def near_matches(code2)
    count = 0
    @pegs.uniq.each do |el|
      count += 1 if code2.pegs.include?(el.downcase) ||
                    code2.pegs.include?(el.upcase)
    end
    f_count = count - self.exact_matches(code2)
    return 0 if f_count < 0
    f_count
  end

  def ==(code2)
    return false if !code2.is_a? Code
    return true if self.exact_matches(code2) == 4
    false
  end

end

class Game
  attr_accessor :guesses
  attr_reader :secret_code

  def initialize(code=Code.random)
    @secret_code = code
    @guesses = 10
  end

  def get_guess
    puts "Please enter a 4-character guess. Your choices are R, G, Y, B, O, and P"
    ans = gets.chomp
    @guesses -= 1
    Code.parse(ans)
  end

  def display_matches(code2)
    exact = @secret_code.exact_matches(code2)
    near = @secret_code.near_matches(code2)
    puts "You got #{exact} exact matches!"
    puts "You got #{near} near matches!"
    exact
  end

  def self.play
    puts "Welcome to Mastermind"
    puts "Please enter a 4-character code. Your choices are R, G, Y, B, O, and P"
    puts "Or press enter to generate a random code"
    ans = gets.chomp
    if ans.empty?
      puts "Generating random code"
      code = Code.random
    else
      code = Code.parse(ans)
    end
    game = Game.new(code)
    puts "You have 10 tries to guess the code! Let's play!"
    loop do
      num_guesses = game.guesses
      puts "You have #{num_guesses} guesses left"
      gcode = game.get_guess
      exact = game.display_matches(gcode)
      if exact == 4
        puts "You guessed the code!"
        break
      elsif @guesses == 0
        puts "You're out of guesses"
        scode = ""
        @secret_code.pegs.each {|ch| scode << ch.downcase}
        puts "The code was #{scode}"
        break
      end
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  Game.play
end
