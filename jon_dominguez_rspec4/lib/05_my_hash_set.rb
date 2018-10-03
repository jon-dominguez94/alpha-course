class MyHashSet

  attr_accessor :store

  def initialize
    @store = {}
  end

  def insert(key)
    @store[key] = true
  end

  def include?(key)
    @store.keys.include?(key)
  end

  def delete(key)
    if self.include?(key)
      @store.delete(key)
      return true
    end
    false
  end

  def to_a
    @store.keys
  end

  def union(set2)
    union = MyHashSet.new
    keys = self.to_a | set2.to_a
    keys.each {|key| union.insert(key)}
    union
  end

  def intersect(set2)
    intersection = MyHashSet.new
    keys = self.to_a & set2.to_a
    keys.each {|key| intersection.insert(key)}
    intersection
  end

  def minus(set2)
    minus = MyHashSet.new
    keys = self.to_a - set2.to_a
    keys.each {|key| minus.insert(key)}
    minus
  end

end
