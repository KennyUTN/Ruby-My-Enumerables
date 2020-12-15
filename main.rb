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
    return size unless block_given?

    n = 0
    my_each do
      n += 1

      n
    end
      end

  def my_inject(var1 , var2)

    return 'Error' if var1.nil? && var2.nil? && !block_given?

    memo = nil
    symbol = nil
    unless var1.nil? && var2.nil?
      memo = var1
      symbol = var2
      my_each do |i|
        memo = memo.send(symbol, i)
      end
    if var1.is_a? Symbol
      symbol = var1
      my_each { |i| memo = (memo ? memo.send(symbol, i) : i) }
    else
      memo = var1
      my_each { |i| memo = (memo ? yield(memo, i) : i) }
    end
    memo
 end
        end
      end
def multiply_els(arg = nil)

        return 'Error' if arg.nil? || !arg.is_a?(Array)

          arg.my_inject(:*)
        end
testo = [1, 2, 3]

puts testo.my_all? { |elem| elem < 8 }

puts testo.my_any? { |elem| elem < 8 }

puts testo.my_count

puts testo.my_inject(0 , :+)

puts multiply_els(testo)
