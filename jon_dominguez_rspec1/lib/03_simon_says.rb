def echo(string)
  string
end

def shout(string)
  string.upcase
end

def repeat(string, n=2)
  result = string
  n -= 1
  n.times { result += " #{string}" }
  result
end

def start_of_word(string, n)
  string[0...n]
end

def first_word(string)
  string.split.first
end

def titleize(string)
  exclude = ["a", "an", "the", "for", "and", "nor", "but", "or", "yet", "so", "over"]
  words = []
  string.split.each_with_index do |word, i|
    if exclude.include?(word) && i != 0
      words << word
    else
      words << word.capitalize
    end
  end
  words.join(" ")
end
