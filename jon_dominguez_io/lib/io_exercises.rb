# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
  valids = ("0".."100").to_a
  answer = (1..100).to_a.sample
  guesses = 0
  puts "I'm thinking of a number from 1-100"
  loop do
    puts "Guess a number!"
    guess = gets.chomp
    if !valids.include?(guess)
      puts "Invalid guess. Try again!"
      next
    else
      guesses += 1
      puts "You guessed #{guess}"
      STDOUT.flush
      guess = guess.to_i
      if guess < answer
        puts "That guess is too low"
        next
      elsif guess > answer
        puts "That guess is too high"
        next
      elsif guess == answer
        puts "You got it! It was #{answer}!"
        puts "You guessed #{guesses} times"
        break
      end
    end
  end
end

if __FILE__ == $0
  #Dir.chdir(File.dirname(__FILE__))
  path = Dir.pwd
  puts "What file would you like to shuffle? (relative to #{path})"
  filename = gets.chomp
  if !File.file?(filename)
    puts "That file doesn't exist"
  else
    contents = File.readlines(filename).shuffle
    new_name = File.basename(filename, ".*")
    newfile = "#{new_name}-shuffled.txt"
    File.open(newfile, "w") do |f|
      contents.each {|line| f.puts(line)}
    end
  end
end
