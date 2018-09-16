class Book
  # TODO: your code goes here!

  attr_accessor :title

  def initialize
    @title = ""
  end

  def title=(name)
    result = []
    excep = ["a", "an", "and", "the", "to", "of", "in"]
    name.split.each_with_index do |word, i|
      if i != 0 && excep.include?(word.downcase)
         result << word
      else
        result << word.capitalize
      end
    end
    @title = result.join(" ")
  end
end
