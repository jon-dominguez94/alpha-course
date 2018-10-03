class Dictionary

  attr_accessor :entries, :keywords

  def initialize
    @entries = {}
    @keywords = []
  end

  def add(entry)
    if entry.is_a? String
      @entries[entry] = nil
      @keywords << entry
    elsif entry.is_a? Hash
      @entries.merge!(entry)
      @keywords << entry.first.first
    end

    @keywords.sort!
  end

  def include?(key)
    @keywords.include?(key)
  end

  def find(prefix)
    @entries.select {|k,v| k.include?(prefix)}
  end

  def printable
    output_string = []
    @keywords.each {|k| output_string << "[#{k}] \"#{@entries[k]}\""}
    output_string.join("\n")
  end

end
