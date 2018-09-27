def measure(iterations=1)
  beginning = Time.now
  iterations.times {yield}
  ending = Time.now
  (ending - beginning)/iterations
end
