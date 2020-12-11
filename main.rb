module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    size.times { |i| yield(to_a[i]) }
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    size.times do |i|
      yield to_a[i], i
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_array = []
    my_each { |i| new_array << i if yield i }
    new_array
  end

    def my_map
      return self.dup unless block_given?

      ary = []
      self.each do |elem|
        ary << yield(elem)
      end

      ary
    end

ary2 = [2, 3, 4]

my_map





def my_map
    return self.dup unless block_given?

    ary = []
    self.my_each do |elem|
      ary << yield(elem)
    end

    ary
  end




def my_select
    return self.dup unless block_given?

    ary = []
    self.my_each do |elem|
      if yield (elem)
         ary << elem
        end
    end
    ary
  end
  def my_reduce
    return self.dup unless block_given?

    ary = []
    self.my_each do |elem|
      if yield (elem)
         ary << elem
        end
    end
    ary
  end
