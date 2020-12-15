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
    my_each do |elem|
      ary << yield(elem)
    end

    ary
  end

  def my_select
    return self.dup unless block_given?

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


    def my_any?
      return nil unless block_given?

      my_each do |elem|
        return true unless yield elem
      end
      false
        end


  def my_none?
          return nil unless block_given?

          my_each do |elem|
            return false unless yield elem
          end
          true
            end

  def my_count
              return self.size unless block_given?

              n = 0
              my_each do n += 1

              n
            end

      end


    end

    testo = [1, 2, 3, 4, 3]

puts testo.my_all? { |elem| elem < 8 }

puts testo.my_any? { |elem| elem < 8 }

puts testo.my_count
