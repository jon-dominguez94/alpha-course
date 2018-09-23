require 'byebug'

ALPHABET = ("a".."z").to_a

class Hangman
  attr_reader :guesser, :referee, :board

  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
    @board = []
  end

  def setup
    length = @referee.pick_secret_word
    @guesser.register_secret_length(length)
    @board = Array.new(length)
  end

  def take_turn
    guess = @guesser.guess(@board)
    matches = @referee.check_guess(guess)
    update_board(guess, matches)
    @guesser.handle_response(guess, matches)
  end

  def update_board(guess, matches)
    matches.each {|i| @board[i] = guess}
  end

  def display
    letters = []
    @board.each do |ch|
      if ch == nil
        letters << "_"
      else
        letters << ch
      end
    end
    puts "Secret word: #{letters.join}\n\n"
  end

  def play
    tries = 0
    setup
    loop do
      break if @board.none? {|ch| ch == nil}
      guesses = @guesser.guesses
      puts "Guessed letters: #{guesses.join(", ")}\n\n"
      display
      take_turn
      tries += 1
      #puts %x{clear}
    end
    puts %x{clear}
    puts "Winner!\n\n"
    display
    puts "Guessed in #{tries} tries!"
  end
end

class HumanPlayer

  attr_reader :guesses

  def initialize(dictionary)
    @dictionary = dictionary
    @guesses = []
    @max = dictionary.sort_by {|word| word.length}.last.length
    @min = dictionary.sort_by {|word| word.length}.first.length
    @secret_length = 0
  end

  def pick_secret_word
    ans = 0
    loop do
      puts "What is the length of your secret word?"
      ans = gets.chomp.strip.to_i
      break if ans.between?(@min, @max)
      puts "There's no word of that length\n\n"
    end
    puts %x{clear}
    @secret_length = ans
  end

  def register_secret_length(length)
    puts "The secret word is #{length} characters long!\n\n"
    @secret_length = length
  end

  def guess(board=[])
    guess = ""
    loop do
      puts "Guess a letter!"
      guess = gets.chomp.strip.downcase
      if guess.length > 1 || !ALPHABET.include?(guess)
        puts "Invalid response"
        next
      elsif board.include?(guess) || @guesses.include?(guess)
        puts "You've already guessed that letter!"
        next
      else
        break
      end
    end
    puts %x{clear}
    @guesses << guess
    guess
  end

  def check_guess(letter)
    pos = []
    loop do
      puts "\n\nThe other player guessed \'#{letter}\'\n\n"
      puts "Enter all positions where this letter is a match. Ex: 1, 3, 5 or 1 3"
      puts "If none, press enter."
      pos = gets.chomp.delete(",").split.map! {|i| i.to_i}

      if pos.include?(0) || pos.any? {|num| !num.between?(1, @secret_length)}
        puts "\n\nInvalid response"
        next
      end
      if !pos.empty?
        puts "Please confirm that \'#{letter}\' appears at position(s): #{pos.join(' ')} and no where else. y/n"
      else
        puts "Please confirm that \'#{letter}\' does not appear in your word. y/n"
      end
      ans = gets.chomp.strip
      next if ans != "y"
      puts "\n\nInvalid response"

      break
    end
    puts %x{clear}
    pos.sort.map {|num| num - 1}
  end

  def handle_response(letter, matches)
    if matches.empty?
      puts "Sorry, no matches\n\n"
    else
      puts "That's a match!\n\n"
    end
  end

end

class ComputerPlayer

  attr_reader :secret_length, :candidate_words, :guesses

  def initialize(dictionary)
    @dictionary = dictionary
    @secret_word = ""
    @candidate_words = dictionary
    @guesses = []
  end

  def pick_secret_word
    @secret_word = @dictionary.sample
    @secret_word.length
  end

  def register_secret_length(length)
    @candidate_words.reject! {|word| word.length != length}
  end

  def guess(board=[])
    raise "Your word isn't in my dictionary!" if @candidate_words.empty?
    freq = Hash.new(0)
    @candidate_words.each do |word|
      word.chars.each {|ch| freq[ch] += 1}
    end
    freq.select! {|k, v| !board.include?(k) && !@guesses.include?(k)}
    guess = freq.sort_by {|k, v| v}.last.first
    @guesses << guess
    guess
  end

  def check_guess(letter)
    idx = []
    raise "Invalid response" if !ALPHABET.include?(letter)
    @secret_word.chars.each_with_index do |ch,i|
      idx << i if ch == letter.downcase
    end
    idx
  end

  def handle_response(letter, matches)
    if matches.empty?
      @candidate_words.reject! {|word| word.include?(letter)}
    else
      @candidate_words.reject! do |word|
        idx = []
        word.chars.each_with_index do |ch,i|
          idx << i if ch == letter.downcase
        end
        idx != matches
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  dictionary = File.readlines("dictionary.txt")
  dictionary.map! {|word| word.chomp}
  puts "\n\nLets play Hangman!\n\n"
  ans = ""
  loop do
    puts "Do you want to be the guesser(g) or the referee(r)?"
    ans = gets.chomp.strip
    break if ["g", "r"].include?(ans)
    puts "Invalid response\n\n"
  end
  puts %x{clear}
  if ans == "r"
    players = {guesser: ComputerPlayer.new(dictionary),
            referee: HumanPlayer.new(dictionary)}
  else
    players = {guesser: HumanPlayer.new(dictionary),
            referee: ComputerPlayer.new(dictionary)}
  end
  game = Hangman.new(players)
  game.play
end
