require_relative '../main.rb'
require 'rspec'

describe Enumerable do
  let(:arr) { [1, 2, 3, 4, 5] }
  let(:numbers) { [1, 5.98, 3] }
  let(:words) { %w[jan ken pon] }
  let(:salad_array) { [nil, false, 69_420] }
  let(:empty_array) { [] }
  let(:hash) { {} }
  let(:hash2) { {} }

  describe '#my_each' do
    subject { arr.each { |i| i * i } }
    it 'Goes through the array 1 at a  time' do
      expect(subject).to eql(arr.my_each { |i| i * i })
    end
  end



    it 'Returns enumerable No block Given' do
        subject { arr.my_each }
      expect subject.to be_a(Enumerable)
    end
  end

  escribe '#my_each_with_index' do


        it 'Travels the array, If block is given ' do
          arr.each_with_index { |i, indx| hash_one[i] = indx }
          arr.my_each_with_index { |i, indx| hash_two[i] = indx }
          expect(hash_one).to eql(hash_two)
        end



        subject { arr.my_each_with_index }
        it 'Returns an enumerator if no block is given' do
          expect(subject).to be_a(Enumerable)

      end
    end

    describe '#my_select' do
      it 'Returns the selected item according to the specified conditions' do
        original = arr.my_select { |x| x > 1 }
        test = arr.my_select { |x| x > 1 }
        expect(test).to eql(original)
      end


        it 'returns an Enumerator when no block given If a block is given' do
          expect(arr.my_select.is_a?(Enumerator)).to be(true)

      end


        it 'Returns an enumerator If no block is given' do
          expect(arr.my_each.is_a?(Enumerable)).to be true

      end
    end

    describe '#my_all' do
      it 'Returns true if the elements are true else it returns an empty array' do
        original = arr.all? { |x| x < 8 }
        test = arr.my_all? { |x| x < 8 }
        expect(test).to eql(original)
      end


        it 'Returns true when all the elements belong to the class' do
          expect(arr.my_all?(Integer)).to eql(true)
        end



      it 'Regexp: returns true when all elements match the passed argument or false otherwise' do
        expect(words.my_all?(/[a-z]/)).to eql(true)
        expect(words.my_all?(/d/)).to eql(false)
      end



        it 'it returns false if a string is given' do
          subject { words.my_all?('hello') }
          expect(subject).to be false
      end



        it 'returns false If a number is given' do
          expect(numbers.my_all?(25)).to be false
        end
    end

    describe '#my_any?' do



        it 'Block: Returns true' do
          subject { words.my_any? { |word| word.length >= 2 } }
          expect(subject).to be true
        end


    
        subject { salad_array.my_any?(Integer) }
        it 'Arg: returns true if theres a element in the array' do
          expect(subject).to be true
        end
      end

      context 'If nor argument is given ' do
        subject { salad_array.my_any? }
        it 'returns true if there a true in the array' do
          expect(subject).to be true
        end
      end

      context 'If a string is given' do
        subject { words.my_all?('hello') }
        it 'it returns false' do
          expect(subject).to be false
        end
      end

      context 'If a number is given' do
        subject { numbers.my_all?(5) }
        it 'returns false' do
          expect(subject).to be false
        end
      end
    end

    describe '#my_none?' do
      context 'If block is given' do
        subject { words.my_none? { |word| word.length == 5 } }
        it 'return true if block never return true for all elemetns' do
          expect(subject).to be true
        end
      end

      context 'If an argument is given' do
        subject { numbers.my_none?(Float) }
        it 'return false if all elements are true' do
          expect(subject).to be false
        end
      end

      context 'If no arguments is given' do
        subject { empty_array.my_none? }
        it 'returns true if all elements are false or nil' do
          expect(subject).to be true
        end
      end

      context 'If a string is given' do
        subject { words.my_all?('hello') }
        it 'it returns false' do
          expect(subject).to be false
        end
      end

      context 'If a number is given' do
        subject { numbers.my_all?(5) }
        it 'returns false' do
          expect(subject).to be false
        end
      end
    end

    describe '#my_count' do
      it 'takes an enumerable collection and counts how many elements match the given criteria.' do
        original_arr = arr.count { |x| x > 5 }
        test_arr = arr.my_count { |x| x > 5 }
        expect(test_arr).to eql(original_arr)
      end

      it 'returns array length when no block given' do
        expect(arr.my_count).to eql(5)
      end

      it 'returns the number of elements that is equal to the given argument' do
        expect(arr.my_count(2)).to eq(1)
      end

      it 'returns the number of elements that match with a given condition' do
        expect(arr.my_count(&:even?)).to eq(2)
      end
    end

    describe '#my_map' do
      it 'returns a new array with the results of running block.' do
        original_arr = arr.map { |x| x * x }
        test_arr = arr.my_map { |x| x * x }
        expect(test_arr).to eql(original_arr)
      end

      it 'returns array of strings when given array of integers' do
        expect(arr.my_map(&:to_s)).to eq(%w[1 2 3 4 5])
      end
    end

    describe '#my_inject' do
      context 'If block is given' do
        subject { arr.my_inject { |sum, n| sum + n } }
        it 'returns an accumulator that stores the result of the block' do
          expect(subject).to eq(arr.inject { |sum, n| sum + n })
        end
      end

      context 'If a symbol is given' do
        subject { arr.my_inject :* }
        it 'returns an accumulator executing the operator symbol' do
          expect(subject).to eq((arr.inject :*))
        end
      end

      context 'If an argument and a block is given' do
        subject { arr.my_inject(1) { |prod, n| prod * n } }
        it 'return an accumulator, the arg is going to be the first value' do
          expect(subject).to eq(arr.inject(1) { |prod, n| prod * n })
        end
      end

      context 'If an argument and a symbol is given' do
        subject { arr.my_inject(1, :*) }
        it 'The argument be the initial value and return an acc exec the symbol' do
          expect(subject).to eq(arr.inject(1, :*))
        end
      end
    end
end
