# function that converts fahrenheit to celsius
def ftoc(fahrenheit)
  ((fahrenheit - 32)/1.8).round
end

# function that converts celsius to fahrenheit
def ctof(celsius)
  celsius * 1.8 + 32
end
