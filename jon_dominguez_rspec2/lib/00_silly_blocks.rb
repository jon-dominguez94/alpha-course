def reverser(&prc)
  string = prc.call
  string.split.map {|word| word.reverse}.join(" ")
end

def adder(add=1)
  yield + add
end

def repeater(n=1)
  n.times {yield}
end
