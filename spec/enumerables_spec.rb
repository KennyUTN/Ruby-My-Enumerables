require_relative '../main.rb'
require 'rspec'

describe Enumerable do
  let(:arr) { [1, 2, 3, 4, 5] }
  let(:word_arr) { %w[jan ken pon] }
  let(:salad_array) { [nil, false, 69420] }
  let(:empty_array) { [] }
  let(:hash) { {} }
  let(:hash2) { {} }

   describe '#my_each' do
      subject { arr.each { |i| i * i } }
      it 'Goes through the array 1 at a  time' do
        expect(subject).to eql(arr.my_each { |i| i * i })
      end
    end

  context 'No block Given' do
  subject {arr.my_each}
  it 'Returns enumerable' do
    expect (subject).to be_a(Enumerable)
  end
end


  # describe '#my_each_with_index' do
  # end

end
