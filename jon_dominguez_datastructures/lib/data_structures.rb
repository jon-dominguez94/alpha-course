# EASY

# Write a method that returns the range of its argument (an array of integers).
def range(arr)
  # your code goes here
  arr = arr.sort
  arr.max - arr.min
end

# Write a method that returns a boolean indicating whether an array is in sorted
# order. Use the equality operator (==), which returns a boolean indicating
# whether its operands are equal, e.g., 2 == 2 => true, ["cat", "dog"] ==
# ["dog", "cat"] => false
def in_order?(arr)
  # your code goes here
  arr == arr.sort
end


# MEDIUM

# Write a method that returns the number of vowels in its argument
def num_vowels(str)
  # your code goes here
  vowels = "aeiou"
  count = 0
  str.downcase.chars.each do |ch|
    if vowels.include?(ch)
      count += 1
    end
  end
  count
end

# Write a method that returns its argument with all its vowels removed.
def devowel(str)
  # your code goes here
  vowels = "aeiou"
  result = ""
  str.downcase.chars.each do |ch|
    unless vowels.include?(ch)
      result += ch
    end
  end
  result
end


# HARD

# Write a method that returns the returns an array of the digits of a
# non-negative integer in descending order and as strings, e.g.,
# descending_digits(4291) #=> ["9", "4", "2", "1"]
def descending_digits(int)
  # your code goes here
  nums = int.to_s.split("")
  nums.sort.reverse
end

# Write a method that returns a boolean indicating whether a string has
# repeating letters. Capital letters count as repeats of lowercase ones, e.g.,
# repeating_letters?("Aa") => true
def repeating_letters?(str)
  # your code goes here
  i = 0
  while i < str.length - 1
    return true if str[i].downcase == str[i + 1].downcase
    i += 1
  end
  false
end

# Write a method that converts an array of ten integers into a phone number in
# the format "(123) 456-7890".
def to_phone_number(arr)
  # your code goes here

  "(" + arr[0..2].join.to_s + ") " + arr[3..5].join.to_s + "-" + arr[6..-1].join.to_s
end

# Write a method that returns the range of a string of comma-separated integers,
# e.g., str_range("4,1,8") #=> 7
def str_range(str)
  # your code goes here
  nums = str.split(",")
  nums = nums.sort
  nums.max.to_i - nums.min.to_i
end


#EXPERT

# Write a method that is functionally equivalent to the rotate(offset) method of
# arrays. offset=1 ensures that the value of offset is 1 if no argument is
# provided. HINT: use the take(num) and drop(num) methods. You won't need much
# code, but the solution is tricky!
def my_rotate(arr, offset=1)
  # your code goes here
  if offset < 1
    until offset.abs <= arr.length
      offset += arr.length
    end
    offset = arr.length + offset
  elsif offset > arr.length
    offset = offset % arr.length
  end
  arr.drop(offset) + arr.take(offset)
end
