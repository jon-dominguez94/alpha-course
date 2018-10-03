class Temperature

  def initialize(temp={})
    @fahrenheit = temp[:f]
    @celsius = temp[:c]
  end

  def in_fahrenheit
    @fahrenheit ? @fahrenheit : ctof(@celsius)
  end

  def in_celsius
    @celsius ? @celsius : ftoc(@fahrenheit)
  end

  def self.from_celsius(celsius)
    Temperature.new(:c => celsius)
  end

  def self.from_fahrenheit(fahrenheit)
    Temperature.new(:f => fahrenheit)
  end

  private

  def ftoc(fahrenheit)
    (fahrenheit - 32) * (5.0/9.0)
  end

  def ctof(celsius)
    celsius * 1.8 + 32
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
