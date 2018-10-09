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
  secret_number = (1..100).to_a.sample
  guesses = 0
  loop do
    puts "I'm thinking of a number between 1 and 100. Guess a number!"
    ans = gets.chomp.strip.to_i
    puts "You guessed #{ans}"
    guesses += 1
    if ans == secret_number
      puts "You got it! That took #{guesses} guesses"
      break
    else
      puts ans > secret_number ? "too high!" : "too low"
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  begin
    puts "Which file would you like to shuffle?"
    filename = gets.chomp.strip
    raise if !File.file?(filename)
  rescue
    puts "Not a file"
    retry
  end
  contents = File.readlines(filename).shuffle
  basename = File.basename(filename, ".*")
  new_file = "#{basename}-shuffled.txt"
  File.open(new_file, "w") do |f|
    contents.each {|line| f.puts(line)}
  end
end
