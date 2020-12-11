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
    return dup unless block_given?

    ary = []
    each do |elem|
      ary << yield(elem)
    end

    ary
  end

  def my_map
    return dup unless block_given?

    ary = []
    my_each do |elem|
      ary << yield(elem)
    end

    ary
    end

  def my_select
    return dup unless block_given?

    ary = []
    my_each do |elem|
      ary << elem if yield elem
    end
    ary
    end

  def my_all?
    return nil unless block_given?

    my_each do |elem|
      return false unless yield elem
    end
    true
      end
    end


testo=[1, 2, 3, 4, 5]


print testo.my_all? {|elem| elem < 8 }
