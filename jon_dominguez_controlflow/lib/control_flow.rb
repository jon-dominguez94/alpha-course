# EASY

# Return the argument with all its lowercase characters removed.
def destructive_uppercase(str)
  lows = ("a".."z").to_a
  str.each_char do |ch|
    if lows.include?(ch)
      str.delete!(ch)
    end
  end
  str

end

# Return the middle character of a string. Return the middle two characters if
# the word is of even length, e.g. middle_substring("middle") => "dd",
# middle_substring("mid") => "i"
def middle_substring(str)
  mid = str.length/2
  if str.length.odd?
    return str[mid]
  else
    return str[mid-1] + str[mid]
  end

end

# Return the number of vowels in a string.
VOWELS = %w(a e i o u)
def num_vowels(str)
  count = 0
  str.each_char do |ch|
    count += 1 if VOWELS.include?(ch)
  end
  count
end

# Return the factoral of the argument (num). A number's factorial is the product
# of all whole numbers between 1 and the number itself. Assume the argument will
# be > 0.
def factorial(num)
  f = 1
  (2..num).each {|n| f *= n}
  f
end


# MEDIUM

# Write your own version of the join method. separator = "" ensures that the
# default seperator is an empty string.
def my_join(arr, separator = "")
  result = ""
  arr.each_with_index do |el, i|
    result << el
    unless i == arr.length - 1
      result << separator
    end
  end
  result
end

# Write a method that converts its argument to weirdcase, where every odd
# character is lowercase and every even is uppercase, e.g.
# weirdcase("weirdcase") => "wEiRdCaSe"
def weirdcase(str)
  result = ""
  str.chars.each_with_index do |ch, i|
    if i.odd?
      result << ch.upcase
    else
      result << ch.downcase
    end
  end
  result
end

# Reverse all words of five more more letters in a string. Return the resulting
# string, e.g., reverse_five("Looks like my luck has reversed") => "skooL like
# my luck has desrever")
def reverse_five(str)
  words = str.split
  words.each do |word|
    if word.length >= 5
      word.reverse!
    end
  end
  words.join(" ")
end

# Return an array of integers from 1 to n (inclusive), except for each multiple
# of 3 replace the integer with "fizz", for each multiple of 5 replace the
# integer with "buzz", and for each multiple of both 3 and 5, replace the
# integer with "fizzbuzz".
def fizzbuzz(n)
  arr = []
  (1..n).each do |i|
    if i % 3 == 0
      if i % 5 == 0
        arr.push("fizzbuzz")
      else
        arr.push("fizz")
      end
    elsif i % 5 == 0
      arr.push("buzz")
    else
      arr.push(i)
    end
  end
  arr
end


# HARD

# Write a method that returns a new array containing all the elements of the
# original array in reverse order.
def my_reverse(arr)
  new_arr = []
  i = arr.length - 1
  while i >= 0
    new_arr.push(arr[i])
    i -= 1
  end
  new_arr
end

# Write a method that returns a boolean indicating whether the argument is
# prime.
def prime?(num)
  factors(num) == [1, num]
end

# Write a method that returns a sorted array of the factors of its argument.
def factors(num)
  facts = []
  (1..num).each do |n|
    facts << n if num % n == 0
  end
  facts
end

# Write a method that returns a sorted array of the prime factors of its argument.
def prime_factors(num)
  facts = factors(num)
  facts.select {|f| prime?(f)}
end

# Write a method that returns the number of prime factors of its argument.
def num_prime_factors(num)
  prime_factors(num).length
end


# EXPERT

# Return the one integer in an array that is even or odd while the rest are of
# opposite parity, e.g. oddball([1,2,3]) => 2, oddball([2,4,5,6] => 5)
def oddball(arr)
  odds = []
  evens = []
  arr.each do |n|
    if n.odd?
      odds << n
    else
      evens << n
    end
  end
  if odds.length == 1
    return odds[0]
  else
    return evens[0]
  end
end
