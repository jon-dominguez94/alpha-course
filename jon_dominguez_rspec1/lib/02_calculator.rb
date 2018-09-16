def add(a, b)
  a + b
end

def subtract(a, b)
  a - b
end

def sum(arr)
  result = 0
  arr.each {|num| result += num}
  result
end

def multiply(*nums)
  nums.reduce(:*)
end

def power(a,b)
  result = a
  b = b - 1
  b.times { result = result*a }
  result
end

def factorial(num)
  result = 1
  if num > 0
    num.downto(1) do |n|
      result *= n
    end
  end
  result
end
