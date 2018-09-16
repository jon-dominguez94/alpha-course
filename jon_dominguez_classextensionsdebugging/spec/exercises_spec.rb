require "rspec"
require "exercises"

describe 'Array#my_select' do
  it 'calls the block passed to it' do
    expect do |block|
      ["test element"].my_select(&block)
    end.to yield_control
  end

  it 'yields each element to the block' do
    test_array = ["el1", "el2", "el3"]
    expect do |block|
      test_array.my_select(&block)
    end.to yield_successive_args("el1", "el2", "el3")
  end

  it 'returns an array of filtered down items' do
    test_array = [1, 2, 3, 4, 5]
    expect(test_array.my_select(&:odd?)).to eq([1, 3, 5])
    expect(test_array.my_select { |el| el < 3 }).to eq([1, 2])
  end

  it 'does NOT call the built in Array#select' do
    test_array = ["el1", "el2", "el3"]
    expect(test_array).not_to receive(:select)
    test_array.my_select {}
  end
end

describe 'Array#my_map' do
  it 'calls the block passed to it' do
    expect do |block|
      ["test array"].my_map(&block)
    end.to yield_control.once
  end

  it 'yields each element to the block' do
    expect do |block|
      ["el1", "el2"].my_map(&block)
    end.to yield_successive_args("el1", "el2")
  end

  it 'runs the block for each element' do
    expect([1, 2, 3].my_map { |el| el * el }).to eq([1, 4, 9])
    expect([-1, 0, 1].my_map { |el| el.odd? }).to eq([true, false, true])
  end

  it 'does NOT call the built in Array#map method' do
    original_array = ["original array"]
    expect(original_array).not_to receive(:map)
    original_array.my_map {}
  end

  it 'is chainable and returns a new array' do
    original_array = ["original array"]
    expect(original_array.my_map {}).not_to eq(original_array)
  end
end


describe "Array#my_find" do
  it "calls the block passed to it" do
    expect do |block|
      ["test element"].my_find(&block)
    end.to yield_control
  end

  it "yields each element to the block" do
    test_array = ["el1", "el2", "el3"]
    expect do |block|
      test_array.my_find(&block)
    end.to yield_successive_args("el1", "el2", "el3")
  end

  it "returns nil if no element is found" do
    expect([2].my_find { |el| el.odd? }).to eq(nil)
  end

  it "returns the first element for which the block evaluates to true" do
    test_array = [1, 2, 3, 4, 5]
    expect(test_array.my_find(&:even?)).to eq(2)
    expect(test_array.my_find { |el| el > 3 }).to eq(4)
  end

  it "does NOT call the built in Array#find" do
    test_array = ["el1", "el2", "el3"]
    expect(test_array).not_to receive(:find)
    expect(test_array).not_to receive(:detect)
    test_array.my_find {}
  end
end

describe 'Array#my_any?' do
  it 'calls the block passed to it' do
    expect do |block|
      [true].my_any?(&block)
    end.to yield_control
  end

  it 'yields each element to the block' do
    test_array = [1, 2, 3]
    expect do |block|
      test_array.my_any?(&block)
    end.to yield_successive_args(1, 2, 3)
  end

  it 'returns false if every call to the block evaluates to false' do
    expect([false, false, false].my_any? { |el| el }).to eq(false)
  end

  it 'returns true if any call to the block evaluates to true' do
    expect([false, false, true].my_any? { |el| el }).to eq(true)
  end

  it 'does NOT call the built in Array#any?' do
    test_array = ["el1", "el2", "el3"]
    expect(test_array).not_to receive(:any?)
    test_array.my_any? {}
  end
end

describe 'Array#my_all?' do
  it 'calls the block passed to it' do
    expect do |block|
      [true].my_all?(&block)
    end.to yield_control
  end

  it 'returns false if any call to the block evaluates to a falsey value' do
    expect([true, false, true].my_all? { |el| el }).to eq(false)
    expect([true, nil, true].my_all? { |el| el }).to eq(false)
  end

  it 'returns true if every call to the block evaluates to true' do
    expect([2, 4, 6].my_all? { |el| el.even? }).to eq(true)
  end

  it 'returns true if every call to the block evaluates to truthy values' do
    expect([:a, :b, :c].my_all? { |el| el }).to eq(true)
  end

  it 'does NOT call the built-in Array#all?, #none?, #any?' do
    test_array = ["el1", "el2", "el3"]

    [:all?, :none?, :any?].each do |method|
      expect(test_array).not_to receive(method)
    end

    test_array.my_all? {}
  end
end

describe "#dups?" do
  it "detects a single duplicated value" do
    expect([1, 3, 0, 1].dups?).to be_truthy
  end

  it "detects multiple duplicated values" do
    expect([1, 3, 0, 3, 1].dups?).to be_truthy
  end

  it "detects values duplicated more than once" do
    expect([1, 3, 4, 3, 0, 3].dups?).to be_truthy
  end

  it "returns false when no duplicates are found" do
    expect([1, 3, 4, 5].dups?).to be_falsey
  end
end

describe 'Hash#my_merge' do
  it 'does not call the built in Hash#merge' do
    test_hash_1 = { a: 10, b: 2 }
    test_hash_2 = { b: 3, c: 4 }
    expect(test_hash_1).not_to receive(:merge)
    expect(test_hash_2).not_to receive(:merge)
    test_hash_1.my_merge(test_hash_2) {}
  end

  it 'provides default merging behavior if no proc given' do
    test_hash_1 = { a: 10, b: 2 }
    test_hash_2 = { b: 3, c: 4 }
    expect(test_hash_1.my_merge(test_hash_2)).to eq({a: 10, b: 3, c: 4})
  end

  it 'yields each element to the block' do
    test_hash_1 = { a: 10, b: 2 }
    test_hash_2 = { b: 3, c: 4 }
    expect { |b| test_hash_1.my_merge(test_hash_2, &b)}.to yield_successive_args([:b, 2, 3])
  end

  it 'returns a hash with the correct key-value pairs' do
    test_hash_1 = { a: 10, b: 2 }
    test_hash_2 = { a: 5, b: 10, c: 3 }
    expect(test_hash_1.my_merge(test_hash_2) { |key, oldval, newval| newval - oldval }).to eq({a: -5, b: 8, c: 3})
  end
end
