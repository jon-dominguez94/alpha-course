# Ruby provides a class named `Set`. A set is an unordered collection of
# values with no duplicates.  You can read all about it in the documentation:
#
# http://www.ruby-doc.org/stdlib-2.1.2/libdoc/set/rdoc/Set.html
#
# Let's write a class named `MyHashSet` that will implement some of the
# functionality of a set. Our `MyHashSet` class will utilize a Ruby hash to keep
# track of which elements are in the set.  Feel free to use any of the Ruby
# `Hash` methods within your `MyHashSet` methods.
#
# Scroll through the specs for descriptions of each method

require "rspec"
require "05_my_hash_set"

describe MyHashSet do
  let(:set1) { MyHashSet.new }
  let(:set2) { MyHashSet.new }

  # Write a `MyHashSet#initialize` method which sets an empty hash object to
  # `@store`. 
  describe "#intialize" do 
    it "store is set to an empty hash obj" do 
      expect(set1.store).to eq({})
    end 
  end 
  
  # Next, write an `#insert(el)` method that stores `el` as a key
  # in `@store`, storing `true` as the value. 
  describe "#insert" do
    it "adds key to @store" do 
      expect(set1.store).to be_empty
      set1.insert("foo")
      expect(set1.store).to have_key("foo")
    end 

    it "returns true" do
      expect(set1.insert("foo")).to be_truthy
    end
  end 

  # Write an `#include?(el)` method that sees if `el` has previously been 
  # `insert`ed by checking the `@store`; return `true` or `false`.
  describe "#include?" do
    context "when the element has been inserted" do
      it "returns true" do
        set1.insert("foo")

        expect(set1.include?("foo")).to be_truthy
      end
    end

    context "when the element has not been inserted" do
      it "returns false" do
        expect(set1.include?("foo")).to be_falsey
      end
    end
  end

  # Write a `#delete(el)` method to remove an item from the set.
  # Return `true` if the item had been in the set, else return `false`.
  describe "#delete" do
    it "removes an element from the set" do
      set1.insert("bar")
      expect(set1.include?("bar")).to be_truthy

      set1.delete("bar")

      expect(set1.include?("bar")).to be_falsey
    end
  end

  # Add a method `#to_a` which returns an array of the items in the set.
  describe "#to_a" do
    it "returns an array" do
      expect(set1.to_a).to be_an(Array)
    end

    it "returns an array containing each element of the set" do
      elements = %w(Hydrogen Helium Lithium Beryllium)
      elements.each { |el| set1.insert(el) }

      expect(set1.to_a).to contain_exactly(*elements)
    end
  end

  describe "set interaction methods" do
    before(:each) do
      set1.insert("Mark Hamill")
      set1.insert("Harrison Ford")
      set1.insert("Anthony Daniels")

      set2.insert("Ewan McGregor")
      set2.insert("Natalie Portman")
      set2.insert("Anthony Daniels")
    end

  # Next, write a method `set1#union(set2)` which returns a new set which
  # includes all the elements in `set1` or `set2` (or both). 
    describe "#union" do
      it "returns a new set" do
        expect(set1.union(set2)).to be_a(MyHashSet)
      end

      it "returns a set containing elements in EITHER set" do
        els = set1.union(set2).to_a

        expect(els).to contain_exactly(
          "Mark Hamill",
          "Harrison Ford",
          "Anthony Daniels",
          "Ewan McGregor",
          "Natalie Portman"
        )
      end
    end

    # Write a `set1#intersect(set2)` method that returns 
    # a new set which includes only those elements that are
    # in both `set1` and `set2`.
    describe "#intersect" do
      it "returns a new MyHashSet instance" do
        expect(set1.intersect(set2)).to be_a(MyHashSet)
      end

      it "returns a set containing elements in BOTH sets" do
        els = set1.intersect(set2).to_a

        expect(els).to contain_exactly("Anthony Daniels")
      end
    end

    # Write a `set1#minus(set2)` method which returns a new set which includes
    # all the items of `set1` that aren't in `set2`.
    describe "#minus" do
      it "returns a new MyHashSet instance" do
        expect(set1.minus(set2)).to be_a(MyHashSet)
      end

      it "returns a set containing elements ONLY in the first set" do
        els = set1.minus(set2).to_a

        expect(els).to contain_exactly(
          "Mark Hamill",
          "Harrison Ford"
        )
      end
    end
  end
end

# Bonus
#
# Code the following methods:
# 1) `set1#symmetric_difference(set2)`
#   it should return the elements contained in either `set1` or `set2`,
#   but not both!
# 2) `set1#==(object)`
#   It should return true if `object` is a `MyHashSet`, has the same size
#   as `set1`, and every member of `object` is a member of `set1`.
# 3) `set1#each(&prc)` method
#   It should iterate through the @store keys