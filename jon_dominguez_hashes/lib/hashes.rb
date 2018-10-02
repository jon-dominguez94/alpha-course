# EASY

# Define a method that, given a sentence, returns a hash of each of the words as
# keys with their lengths as values. Assume the argument lacks punctuation.
def word_lengths(str)
  words_with_lengths = {}
  str.split.each {|word| words_with_lengths[word] = word.length}
  words_with_lengths
end

# Define a method that, given a hash with integers as values, returns the key
# with the largest value.
def greatest_key_by_val(hash)
  hash.sort_by {|k, v| v}.last.first
end

# Define a method that accepts two hashes as arguments: an older inventory and a
# newer one. The method should update keys in the older inventory with values
# from the newer one as well as add new key-value pairs to the older inventory.
# The method should return the older inventory as a result. march = {rubies: 10,
# emeralds: 14, diamonds: 2} april = {emeralds: 27, moonstones: 5}
# update_inventory(march, april) => {rubies: 10, emeralds: 27, diamonds: 2,
# moonstones: 5}
def update_inventory(older, newer)
  newer.each {|k,v| older[k] = v}
  older
end

# Define a method that, given a word, returns a hash with the letters in the
# word as keys and the frequencies of the letters as values.
def letter_counts(word)
  char_counts = Hash.new(0)
  word.chars.uniq.each {|ch| char_counts[ch] = word.count(ch)}
  char_counts
end

# MEDIUM

# Define a method that, given an array, returns that array without duplicates.
# Use a hash! Don't use the uniq method.
def my_uniq(arr)
  uniq_hash = {}
  arr.each {|el| uniq_hash[el] = true}
  uniq_hash.keys
end

# Define a method that, given an array of numbers, returns a hash with "even"
# and "odd" as keys and the frequency of each parity as values.
def evens_and_odds(numbers)
  parity_count = {even: 0, odd: 0}
  numbers.each do |num|
    num.odd? ? parity_count[:odd] += 1 : parity_count[:even] += 1
  end
  parity_count
end

# Define a method that, given a string, returns the most common vowel. Do
# not worry about ordering in the case of a tie. Assume all letters are
# lower case.
def most_common_vowel(string)
  vowels = "aeiou"
  vowel_count = Hash.new(0)
  string.chars.each {|ch| vowel_count[ch] += 1 if vowels.include?(ch)}
  vowel_count.sort_by {|k,v| v}.last.first
end

# HARD

# Define a method that, given a hash with keys as student names and values as
# their birthday months (numerically, e.g., 1 corresponds to January), returns
# every combination of students whose birthdays fall in the second half of the
# year (months 7-12). students_with_birthdays = { "Asher" => 6, "Bertie" => 11,
# "Dottie" => 8, "Warren" => 9 }
# fall_and_winter_birthdays(students_with_birthdays) => [ ["Bertie", "Dottie"],
# ["Bertie", "Warren"], ["Dottie", "Warren"] ]
def fall_and_winter_birthdays(students)
  combos = []
  valid_students = students.select{|k,v| v > 6}.keys
  valid_students.each_with_index do |el, i|
    (i+1...valid_students.length).each do |j|
      combos << [el, valid_students[j]]
    end
  end
  combos
end

# Define a method that, given an array of specimens, returns the biodiversity
# index as defined by the following formula: number_of_species**2 *
# smallest_population_size / largest_population_size biodiversity_index(["cat",
# "cat", "cat"]) => 1 biodiversity_index(["cat", "leopard-spotted ferret",
# "dog"]) => 9
def biodiversity_index(specimens)
  species_count = Hash.new(0)
  specimens.each {|animal| species_count[animal] += 1}
  left = species_count.keys.length ** 2
  right = species_count.values.min / species_count.values.max
  left * right
end

# Define a method that, given the string of a respectable business sign, returns
# a boolean indicating whether pranksters can make a given vandalized string
# using the available letters. Ignore capitalization and punctuation.
# can_tweak_sign("We're having a yellow ferret sale for a good cause over at the
# pet shop!", "Leopard ferrets forever yo") => true
def can_tweak_sign?(normal_sign, vandalized_sign)
  vandalized_letters = character_count(vandalized_sign)
  normal_letters = character_count(normal_sign)
  vandalized_letters.each do |k,v|
    return false if (!normal_letters[k] || normal_letters[k] < v)
  end
  true
end

def character_count(str)
  char_count = Hash.new(0)
  str.downcase.delete(",.?;:!-").chars.each {|ch| char_count[ch] += 1}
  char_count
end
