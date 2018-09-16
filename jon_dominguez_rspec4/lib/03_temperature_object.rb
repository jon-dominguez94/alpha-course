class Temperature
  # TODO: your code goes here!
  attr_accessor :fahrenheit, :celsius

  def initialize(temp={})
    @fahrenheit = temp[:f]
    @celsius = temp[:c]
  end

  def in_fahrenheit
    return ctof(@celsius) if !fahrenheit
    @fahrenheit
  end

  def in_celsius
    return ftoc(@fahrenheit) if !celsius
    @celsius
  end

  def ctof(num)
    1.8*num + 32
  end

  def ftoc(num)
    (num-32) * 5.0 /9.0
  end

  def self.from_celsius(num)
    Temperature.new(:c => num)
  end

  def self.from_fahrenheit(num)
    Temperature.new(:f => num)
  end

end

# Subclasses/Inheritance
class Celsius < Temperature
  def initialize(celsius)
    @celsius = celsius
  end
end

class Fahrenheit < Temperature
  def initialize(fahrenheit)
    @fahrenheit = fahrenheit
  end
end
