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
      @entries = entry.merge(@entries)#[entry.first.first] = entry.first.last
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
    output_string = ""
    @entries.each {|k,v| output_string += "[#{k}] \"#{v}\"\n"}
    output_string.chomp
  end

end
