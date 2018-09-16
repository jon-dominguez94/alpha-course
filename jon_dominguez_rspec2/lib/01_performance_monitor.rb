def measure(n=1, &prc)
  beginning = Time.now
  n.times {prc.call}
  ending = Time.now
  (ending - beginning)/n
end
