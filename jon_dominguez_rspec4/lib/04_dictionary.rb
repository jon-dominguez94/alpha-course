class Dictionary
  # TODO: your code goes here!

  attr_accessor :entries, :keywords

  def initialize
    @entries = {}
    @keywords = []
  end

  def add(ent)
    if ent.is_a? Hash
      @entries.merge!(ent) if
      @keywords << ent.first.first
    elsif ent.is_a? String
      @entries[ent] = nil
      @keywords << ent
    end
    @keywords = @keywords.sort
  end

  def include?(key)
    keywords.include?(key)
  end

  def find(key)
    @entries.select {|k,v| k.include?(key)}
  end

  def printable
    string = []
    @entries.sort.each {|k,v| string << "[#{k}] \"#{v}\""}
    string.join("\n")
  end
end
