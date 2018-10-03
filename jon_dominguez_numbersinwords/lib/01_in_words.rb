UNIQUES = {
  0 => "zero",
  1 => "one",
  2 => "two",
  3 => "three",
  4 => "four",
  5 => "five",
  6 => "six",
  7 => "seven",
  8 => "eight",
  9 => "nine",
  10 => "ten",
  11 => "eleven",
  12 => "twelve",
  13 => "thirteen",
  14 => "fourteen",
  15 => "fifteen",
  16 => "sixteen",
  17 => "seventeen",
  18 => "eighteen",
  19 => "nineteen",
}

TENS = {
  20 => "twenty",
  30 => "thirty",
  40 => "forty",
  50 => "fifty",
  60 => "sixty",
  70 => "seventy",
  80 => "eighty",
  90 => "ninety",
}

BIGS = {
  100 => "hundred",
  1000 => "thousand",
  1_000_000 => "million",
  1_000_000_000 => "billion",
  1_000_000_000_000 => "trillion",
}

class Fixnum
  def in_words
    if self < 100
      if self < 20 || self % 10 == 0
        return UNIQUES[self] || TENS[self]
      else
        ten, single = self.divmod(10)
        ten *= 10
        return "#{TENS[ten]} #{UNIQUES[single]}"
      end
    else
      big = BIGS.keys.select{|k| k <= self}.last
      quotient, rem = self.divmod(big)
      if rem == 0
        "#{UNIQUES[quotient]} #{BIGS[big]}"
      else
        "#{quotient.in_words} #{BIGS[big]} #{rem.in_words}"
      end
    end
  end

end
