def reverser(&prc)
  string = prc.call
  words = string.split
  words.map {|word| word.reverse}.join(" ")
end

def adder(add=1)
  num = yield
  num + add
end

def repeater(n=1)
  n.times {yield}
end
