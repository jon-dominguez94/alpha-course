class MyHashSet
  # TODO: your code goes here!
  attr_accessor :store

  def initialize
    @store = {}
  end

  def insert(key)
    @store[key] = true
  end

  def include?(key)
    @store.key?(key)
  end

  def delete(key)
    @store.delete(key)
  end

  def to_a
    @store.keys
  end

  def union(set2)
    result = self
    set2.to_a.each {|k| result.insert(k)}
    result
  end

  def intersect(set2)
    result = MyHashSet.new
    self.to_a.each {|key| result.insert(key) if set2.include?(key)}
    result
  end

  def minus(set2)
    result = self
    self.to_a.each {|key| result.delete(key) if set2.include?(key)}
    result
  end

end
