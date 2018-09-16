# # Topics:
# * floating-point math
# * objects
# * constructors
# * class methods
# * factory methods
# * options hashes
#
# # Hints - Part 1
#
# Temperature Conversion: one degree fahrenheit is 5/9 of one degree celsius,
# and that the freezing point of water is 0 degrees celsius but 32
# degrees fahrenheit.
#
# The temperature object's constructor should accept an *options hash*
# which contains either a `:celsius` entry or a `:fahrenheit` entry.

require "03_temperature_object"

describe Temperature do
  describe "can be constructed with an options hash" do
    describe "in degrees fahrenheit" do
      it "#in_fahrenheit: without conversion" do
        # Temperature.new(:f => 50) is the same as Temperature.new({f: 50})
        expect(Temperature.new(:f => 50).in_fahrenheit).to eq(50)
      end

      describe "#in_celsius: with conversion" do
        it "at freezing point of water" do
          expect(Temperature.new(:f => 32).in_celsius).to eq(0)
        end

        it "at boiling point of water" do
          expect(Temperature.new(:f => 212).in_celsius).to eq(100)
        end

        it "at body temperature" do
          expect(Temperature.new(:f => 98.6).in_celsius).to eq(37)
        end

        it "at an arbitrary temperature" do
          expect(Temperature.new(:f => 68).in_celsius).to eq(20)
        end
      end
    end

    describe "in degrees celsius" do
      it "#in_celsius: without conversion" do
        expect(Temperature.new(:c => 50).in_celsius).to eq(50)
      end

      describe "#in_celsius: with conversion" do
        it "at freezing point of water" do
          expect(Temperature.new(:c => 0).in_fahrenheit).to eq(32)
        end

        it "at boiling point of water" do
          expect(Temperature.new(:c => 100).in_fahrenheit).to eq(212)
        end

        it "at body temperature" do
          expect(Temperature.new(:c => 37).in_fahrenheit).to be_within(0.1).of(98.6)
          # Why do we need to use be_within here?
          # See http://www.ruby-forum.com/topic/169330
          # and http://groups.google.com/group/rspec/browse_thread/thread/f3ebbe3c313202bb
          # Also, try "puts 0.5 - 0.4 - 0.1" -- pretty crazy, right?
        end
      end
    end
  end


  # # Hints - Part 2

  # In the methods above, we created an instance of a Temperature class
  # and called *instance* methods Temperature#in_celsius or 
  # Temperature#in_fahrenheit. In the methods below, you'll be creating a
  # *factory method*. More about factory methods can be found in the
  # Alpha Curriculum Classes 2 reading .

  # Factory Method is a design pattern, not a Ruby language feature.
  # One way to implement this pattern in Ruby is via class methods --
  # that is, methods defined on the class (Temperature) rather than
  # on individual instances of the class.
  describe "can be constructed via factory methods" do
    it "in degrees celsius" do
      # Remember to define the `from_celsius` factory method as a *class*
      # method, not an *instance* method.
      expect(Temperature.from_celsius(50).in_celsius).to eq(50)
      expect(Temperature.from_celsius(50).in_fahrenheit).to eq(122)
    end

    it "in degrees fahrenheit" do
      expect(Temperature.from_fahrenheit(50).in_fahrenheit).to eq(50)
      expect(Temperature.from_fahrenheit(50).in_celsius).to eq(10)
    end

  end

  # test-driving bonus:
  #
  # 1. make two class methods -- ftoc and ctof
  # 2. refactor to call those methods from the rest of the object
  #
  # run *all* the tests during your refactoring, to make sure you did it right
  #
  describe "utility class methods" do
  end


  # NOTE: We do not go over this in Alpha Curriculum
  # Here's another way to solve the problem!
  describe "using Temperature subclasses/inheritance" do
    describe "Celsius subclass" do
      it "is a Temperature subclass" do
        expect(Celsius.new(0)).to be_a(Temperature)
      end

      it "is constructed in degrees celsius" do
        # The argument is an integer now!
        expect(Celsius.new(50).in_celsius).to eq(50)
        expect(Celsius.new(50).in_fahrenheit).to eq(122)
      end
    end

    describe "Fahrenheit subclass" do
      it "is a Temperature subclass" do
        expect(Fahrenheit.new(0)).to be_a(Temperature)
      end

      it "is constructed in degrees fahrenheit" do
        expect(Fahrenheit.new(50).in_fahrenheit).to eq(50)
        expect(Fahrenheit.new(50).in_celsius).to eq(10)
      end
    end
  end
end