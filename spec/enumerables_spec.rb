require_relative '../enumerable'
#   #my_all tests
describe '#my_all' do
  let(:range) { Range.new(5, 50) }
  let(:true_block) { proc { |num| num <= 9 } }
  let(:false_block) { proc { |num| num > 9 } }
  let(:words) { %w[dog door rod blade] }
  let(:array) { Array.new(100) { rand(0...9) } }
  let(:true_array) { [1, true, 'hi', []] }
  let(:false_array) { [1, false, 'hi', []] }

  it 'should return true if block never returns false or nil' do
    expect(array.my_all?(&true_block) == array.all?(&true_block)).to eql(true)
  end

  it 'should return true if block returns false or nil' do
    expect(array.my_all?(&false_block) == array.all?(&false_block)).to eql(true)
  end

  it 'should return true if block returns false or nil:range' do
    expect(range.my_all?(&false_block) == range.all?(&false_block)).to eql(true)
  end

  it 'should return true if all elements of an array are true' do
    expect(true_array.my_all? == true_array.all?).to eql(true)
  end

  it 'should return true if any of elements of an array are false' do
    expect(false_array.my_all? == false_array.all?).to eql(true)
  end

  it 'must return true when regex is passed as an argument all of the collection matches the regex' do
    expect(words.my_all?(/d/) == words.all?(/d/)).to eql(true)
  end

  it 'must return true when regex is passed as an argument all of the collection does not match the regex' do
    expect(words.my_all?(/o/) == words.all?(/o/)).to eql(true)
  end

  it 'pattern other than regex or class given return true if all collection matches the pattern of local var' do
    array = []
    10.times { array << 3 }
    expect(array.my_all?(3) == array.all?(3)).to eql(true)
  end

  it 'pattern other than regex or class given return true if all collection matches the pattern of global var' do
    expect(array.my_all?(3) == array.all?(3)).to eql(true)
  end

  it 'should return true if all elements are of Integer type' do
    expect(array.my_all?(Integer) == array.all?(Integer)).to eql(true)
  end

  it 'should return true if all elements are of Numeric type' do
    expect(array.my_all?(Numeric) == array.all?(Numeric)).to eql(true)
  end
end

#   #my_any tests
describe '#my_any' do
  let(:words) { %w[dog door rod blade] }
  let(:array) { Array.new(100) { rand(0...9) } }
  let(:range) { Range.new(5, 50) }
  let(:true_block) { proc { |num| num <= 9 } }
  let(:false_block) { proc { |num| num > 9 } }
  let(:false_array) { [1, false, 'hi', []] }

  it 'should return true if block returns false or nil' do
    expect(array.my_any?(&false_block) == array.any?(&false_block)).to eql(true)
  end

  it 'should return true if block returns false or nil:range' do
    expect(range.my_any?(&false_block) == range.any?(&false_block)).to eql(true)
  end

  it 'should return true if any of elements of an array are false' do
    expect(false_array.my_any? == false_array.any?).to eql(true)
  end

  it 'should return true when regex is passed as an argument if any of the collection matches the regex' do
    expect(words.my_any?(/z/) == words.any?(/z/)).to eql(true)
  end

  it 'should return true when string is passed as an argument if any of the collection matches the given string' do
    expect(words.my_any?('cat') == words.any?('cat')).to eql(true)
  end

  it 'should return true if any of elements of an array are type of Integer' do
    expect(words.my_any?(Integer) == words.any?(Integer)).to eql(true)
  end
end

#   my_each tests
describe '#my_each' do
  it 'check each element of an array' do
    expect(%w[aca verissimo henry].my_each do |x|
             p x != 'aca'
           end == %w[aca verissimo henry].each do |x|
                    p x != 'aca'
                  end).to eql(true)
  end
  it 'check each element of an array' do
    expect([1, 2, 3, 4, 5].my_each do |x|
             p x > 3
           end == [1, 2, 3, 4, 5].each do |x|
                    p x > 3
                  end).to eql(true)
  end
  it 'return true if it is an Enumerator' do
    expect([1, 2, 3].my_each.instance_of?(Enumerator)).to eql(true)
  end
end

#   my_each_with_index tests

describe '#my_each_with_index' do
  it 'should check each element of an array' do
    expect(%w[aca verissimo henry].my_each_with_index do |x|
             p x != 'aca'
           end == %w[aca verissimo henry].each do |x|
                    p x != 'aca'
                  end).to eql(true)
  end
  it 'check each element of an array' do
    expect([1, 2, 3, 4, 5].my_each_with_index do |x|
             p x > 3
           end == [1, 2, 3, 4, 5].each do |x|
                    p x > 3
                  end).to eql(true)
  end
  it 'return true if it is an Enumerator' do
    expect([1, 2, 3].my_each_with_index.instance_of?(Enumerator)).to eql(true)
  end
end

#   my_inject tests

describe '#my_inject' do
  let(:search) { proc { |memo, word| memo.length > word.length ? memo : word } }
  let(:words) { %w[dog door rod blade] }
  let(:array) { Array.new(100) { rand(0...9) } }
  let(:range) { Range.new(5, 50) }

  it 'search for the longest word in array of strings' do
    expect(words.my_inject(&search) == words.inject(&search)).to eql(true)
  end

  it 'check if original array is not mutated ' do
    array_clone = array.clone
    array.my_inject { |num| num + 1 }
    expect(array == array_clone).to eql(true)
  end

  it 'when a block is given without initial value it combines all elements of enum, apply binary spc by block' do
    operation = proc { |sum, n| sum + n }
    expect(array.my_inject(&operation) == array.inject(&operation)).to eql(true)
  end

  it 'when block is given without initial value it combines all elements of enum, apply binary spc by block:range' do
    actual = range.my_inject { |prod, n| prod * n }
    expected = range.inject { |prod, n| prod * n }
    expect(actual == expected).to eql(true)
  end

  it 'when symbol is given without initial value it combines all elements of enum, apply binary spc b named method' do
    expect(array.my_inject(:+) == array.inject(:+)).to eql(true)
  end

  it 'when symbol is given without initial value it combines all elements of enum, apply binary spc b named method' do
    expect(array.my_inject(:*) == array.inject(:*)).to eql(true)
  end

  it ' when a sym is specified with an initial value, sym as named method ' do
    expect(array.my_inject(20, :*) == array.inject(20, :*)).to eql(true)
  end

  it ' when a sym is specified with an initial value: sym as named method range ' do
    expect(range.my_inject(2, :*) == range.inject(2, :*)).to eql(true)
  end
end

#   #my_map tests
describe '#my_map' do
  let(:my_proc) { proc { |num| num > 10 } }
  let(:array) { Array.new(100) { rand(0...9) } }

  it 'executes only the proc when the block and proc is given' do
    expect(array.my_map(&my_proc) == array.map(&my_proc)).to eql(true)
  end
end

#   #my_none tests
describe '#my_none' do
  let(:words) { %w[dog door rod blade] }
  let(:array) { Array.new(100) { rand(0...9) } }
  let(:range) { Range.new(5, 50) }
  let(:true_block) { proc { |num| num <= 9 } }
  let(:false_block) { proc { |num| num > 9 } }
  let(:true_array) { [1, true, 'hi', []] }

  it 'should return true if block never returns false or nil' do
    expect(array.my_none?(&true_block) == array.none?(&true_block)).to eql(true)
  end

  it 'should return true if block never returns false or nil:range' do
    expect(range.my_none?(&false_block) == range.none?(&false_block)).to eql(true)
  end

  it 'should return true if all of elements of an array are true' do
    expect(true_array.my_none? == false).to eql(true)
  end

  it 'should return true when regex is passed as an argument if none of the collection matches the regex' do
    expect(words.my_none?(/z/) == words.none?(/z/)).to eql(true)
  end

  it 'should return true when number is passed as an argument if none of the collection includes given number' do
    expect(words.my_none?(5) == words.none?(5)).to eql(true)
  end
end

#   #my_count tests
describe '#my_count' do
  it 'should counts the even numbers' do
    expect([11, 12, 14, 9, 8].my_count(&:even?)).to be(3)
  end
  it 'should counts the words in a string that is longer than 4 characters ' do
    expect(%w[henry verissimo test code].my_count { |el| el.length > 4 }).to be(2)
  end
  it 'should counts the number of hash values that are odd number' do
    expect({ k1: 10, k2: 9, k3: 8, k4: 7 }.my_count { |_k, v| v.odd? }).to eq(2)
  end
  it 'should counts the number os words has the b character ' do
    expect(%w[henry verissimo test code].my_count(/b/)).to be(0)
  end

  it 'should counts the number of times the number three in the array ' do
    expect([1, 2, 3, 4, 3, 3].my_count(3)).to be(3)
  end
  it 'should counts the number of the words in a given array ' do
    expect(%w[henry verissimor test code].my_count { |word| word.count(word) }).to be(4)
  end

  it 'should counts the number of the elemnts in the array ' do
    expect([1, 2, 4, 3].my_count).to be(4)
  end
end

#   #my_select tests
describe '#my_select' do
  it 'should return true if block returns false or nil' do
    expect([1, 2, 3, 4, 5].my_select(&:odd?) == [1, 2, 3, 4, 5].select(&:odd?)).to eql(true)
  end
  it 'should return true if block returns false or nil' do
    expect([1, 2, 3, 4, 5].my_select { |n| n > 3 } == [1, 2, 3, 4, 5].select { |n| n > 3 }).to eql(true)
  end
  it 'should return true if it is an Enumerator' do
    expect([1, 2, 3].my_select.instance_of?(Enumerator)).to eql(true)
  end
end

#   multiply_els test
describe '#multiply_els' do
  it 'should return true based on calc of #my_inject' do
    expect(multiply_els([2, 4, 5]) == 40).to eql(true)
  end
  it 'should return false based on calc of  #my_inject' do
    expect(multiply_els([2, 4, 5]) == 50).to eql(false)
  end
end
