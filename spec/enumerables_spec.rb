require_relative '../main.rb'
# rubocop: disable  Lint/Void
describe Enumerable do
  let(:normal_array) { [1, 2, 3, 4, 5] }
  let(:words) { %w[ant bear cat] }
  let(:salad) { [nil, true, 99] }
  let(:numbers) { [1, 3.14, 2i] }
  let(:empty_array) { [] }
  let(:hash) { {} }
  let(:hash2) { {} }

  describe '#my_each' do
    it 'Block Given, Travels array' do
      expect(normal_array.each { |i| i * i }).to eql(normal_array.my_each { |i| i * i })
    end
    it 'No Block Given, Returns Enum' do
      expect(normal_array.my_each).to be_a(Enumerable)
    end
  end

  describe '#my_each_with_index' do
    it 'Block Given, Travels array with index' do
      normal_array.each_with_index { |i, indx| hash[i] = indx }
      normal_array.my_each_with_index { |i, indx| hash2[i] = indx }
      expect(hash).to eql(hash2)
    end

    subject { normal_array.my_each_with_index }
    it 'No block, returns enum' do
      expect(subject).to be_a(Enumerable)
    end
  end

  describe '#my_select' do
    it 'Returns the selected item of specific condition' do
      original_arr = normal_array.my_select { |x| x > 2 }
      test_arr = normal_array.my_select { |x| x > 2 }
      expect(test_arr).to eql(original_arr)
    end

    it 'returns an Enumerator when no block given' do
      expect(normal_array.my_select.is_a?(Enumerator)).to be(true)
    end

    it 'No block Given, Returns an enumerator' do
      expect(normal_array.my_each.is_a?(Enumerable)).to be true
    end
  end

  describe '#my_all' do
    it 'Returns true if all elements meets condition' do
      original_arr = normal_array.all? { |x| x > 0 }
      test_arr = normal_array.my_all? { |x| x > 0 }
      expect(test_arr).to eql(original_arr)
    end

    it 'Argument: Returns true when all the elements belong to the class' do
      expect(normal_array.my_all?(Integer)).to eql(true)
      expect(normal_array.my_all?(String)).to eql(false)
    end

    it 'Regexp: returns true if elements match regexp, false otherwise' do
      expect(words.my_all?(/[a-z]/)).to eql(true)
      expect(words.my_all?(/d/)).to eql(false)
    end

    subject { words.my_all?('hello') }
    it 'If string given: it returns false' do
      expect(subject).to be false
    end

    subject { numbers.my_all?(5) }
    it 'Number given: returns false' do
      expect(subject).to be false
    end
  end

  describe '#my_any?' do
    it 'Block Given: Returns true if ever return a value other than false or nil' do
      expect(words.my_any? { |word| word.length >= 3 }).to be true
    end

    subject { words.my_all?('hello') }
    it 'String given: it returns false' do
      expect(subject).to be false
    end

    subject { numbers.my_all?(8) }
    it 'Number given: returns false' do
      expect(subject).to be false
    end
  end

  describe '#my_none?' do
    it 'Block Given: return true if block never return true for all elemetns' do
      expect(words.my_none? { |word| word.length == 5 }).to be true
    end

    it 'Argument Given: return false if all elements are true' do
      expect(numbers.my_none?(Float)).to be false
    end

    subject { empty_array.my_none? }
    it 'no arg given returns true if all elements are false or nil' do
      expect(empty_array.my_none?).to be true
    end

    it 'String given: it returns false' do
      expect(words.my_all?('non_existant_string')).to be false
    end

    subject { numbers.my_all?(5) }
    it 'Number given: returns false' do
      expect(numbers.my_all?(6)).to be false
    end
  end

  describe '#my_count' do
    it 'Compares count to my_count' do
      original_arr = normal_array.count { |x| x > 5 }
      test_arr = normal_array.my_count { |x| x > 5 }
      expect(test_arr).to eql(original_arr)
    end

    it 'No block Given: Returns length' do
      expect(normal_array.my_count).to eql(5)
    end

    it 'Counts a specific element' do
      expect(normal_array.my_count(2)).to eq(1)
    end

    it 'Counts elements that match a condition' do
      expect(normal_array.my_count(&:even?)).to eq(2)
    end
  end

  describe '#my_map' do
    it 'Compares map to my_map' do
      original_arr = normal_array.map { |x| x * x }
      test_arr = normal_array.my_map { |x| x * x }
      expect(test_arr).to eql(original_arr)
    end

    it 'Turns a number array to a string array' do
      expect(normal_array.my_map(&:to_s)).to eq(%w[1 2 3 4 5])
    end
  end

  describe '#my_inject' do
    it 'Block Given: returns an accumulator that stores the result of the block' do
      expect(normal_array.my_inject { |sum, n| sum + n }).to eq(normal_array.inject { |sum, n| sum + n })
    end

    it 'Symbol Given: returns an accumulator executing the operator symbol' do
      expect(normal_array.my_inject(:*)).to eq((normal_array.inject :*))
    end

    it 'Arg + Block given : return an accumulator, the arg is going to be the first value' do
      expect(normal_array.my_inject(1) { |prod, n| prod * n }).to eq(normal_array.inject(1) { |prod, n| prod * n })
    end

    it 'Arg + Symbol Given: Executes the symbol on accumulator, the argument is first value' do
      expect(normal_array.my_inject(1, :*)).to eq(normal_array.inject(1, :*))
    end
  end
  describe '#multiply_els' do
    it 'Checks if it returns the correct value' do
      expect(multiply_els(normal_array)).to eq(120)
    end
  end
  # rubocop: enable  Lint/Void
end
