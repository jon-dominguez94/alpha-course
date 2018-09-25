# EASY

# Return the argument with all its lowercase characters removed.
def destructive_uppercase(str)
  result = ""
  str.each_char {|ch| result << ch if ch < "a"}
  result
end

# Return the middle character of a string. Return the middle two characters if
# the word is of even length, e.g. middle_substring("middle") => "dd",
# middle_substring("mid") => "i"
def middle_substring(str)
  mid = str.length / 2
  str.length.odd? ? str[mid] : str[mid - 1] + str[mid]
end

# Return the number of vowels in a string.
VOWELS = %w(a e i o u)
def num_vowels(str)
  count = 0
  str.each_char {|ch| count += 1 if VOWELS.include?(ch)}
  count
end

# Return the factoral of the argument (num). A number's factorial is the product
# of all whole numbers between 1 and the number itself. Assume the argument will
# be > 0.
def factorial(num)
  (1..num).to_a.reduce(:*)
end


# MEDIUM

# Write your own version of the join method. separator = "" ensures that the
# default seperator is an empty string.
def my_join(arr, separator = "")
  return "" if arr.empty?
  joined_str = ""
  arr[0...-1].each {|elem| joined_str << elem + separator}
  joined_str << arr[-1]
end

# Write a method that converts its argument to weirdcase, where every odd
# character is lowercase and every even is uppercase, e.g.
# weirdcase("weirdcase") => "wEiRdCaSe"
def weirdcase(str)
  result = ""
  str.chars.each_with_index do |ch, i|
    result += i.odd? ? ch.upcase : ch.downcase
  end
  result
end

# Reverse all words of five more more letters in a string. Return the resulting
# string, e.g., reverse_five("Looks like my luck has reversed") => "skooL like
# my luck has desrever")
def reverse_five(str)
  words = str.split
  words.each {|word| word.reverse! if word.length >= 5}
  words.join(" ")
end

# Return an array of integers from 1 to n (inclusive), except for each multiple
# of 3 replace the integer with "fizz", for each multiple of 5 replace the
# integer with "buzz", and for each multiple of both 3 and 5, replace the
# integer with "fizzbuzz".
def fizzbuzz(n)
  numbers = []
  (1..n).each do |num|
    if num % 3 == 0
      value = (num % 5 == 0) ? "fizzbuzz" : "fizz"
      numbers << value
    elsif num % 5 == 0
      numbers << "buzz"
    else
      numbers << num
    end
  end
  numbers
end


# HARD

# Write a method that returns a new array containing all the elements of the
# original array in reverse order.
def my_reverse(arr)
  arr.reverse
end

# Write a method that returns a boolean indicating whether the argument is
# prime.
def prime?(num)
  factors(num) == [1, num]
end

# Write a method that returns a sorted array of the factors of its argument.
def factors(num)
  factors = []
  (1..num/2).each {|n| factors << n if num % n == 0}
  factors << num
end

# Write a method that returns a sorted array of the prime factors of its argument.
def prime_factors(num)
  factors(num).select {|n| prime?(n)}
end

# Write a method that returns the number of prime factors of its argument.
def num_prime_factors(num)
  prime_factors(num).length
end


# EXPERT

# Return the one integer in an array that is even or odd while the rest are of
# opposite parity, e.g. oddball([1,2,3]) => 2, oddball([2,4,5,6] => 5)
def oddball(arr)
  evens = []
  odds = []
  arr.each do |int|
    if int.even?
      evens << int
    else
      odds << int
    end
  end
  evens.length > 1 ? odds[0] : evens[0]
end
