class Book
  attr_accessor :title

  def initialize
    @title = ""
  end

  def title=(full)
    articles = ["a", "an", "and", "the", "of", "in", "to"]
    words = full.split.map.with_index {|word, i|
      (articles.include?(word) && i != 0) ? word : word.capitalize}
    @title = words.join(" ")
  end
end
