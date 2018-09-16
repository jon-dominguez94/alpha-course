def translate(string)
  vowels = "aeiou"
  result = []
  string.split.each do |word|
    until vowels.include?(word[0])
      if word[0..1] == "qu"
        word = word[2..-1] + word[0..1]
      else
        word = word[1..-1] + word[0]
      end
    end
    word += "ay"
    result << word
  end
  result.join(" ")
end
