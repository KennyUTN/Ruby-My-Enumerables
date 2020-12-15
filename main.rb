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


  def my_map(proc = nil)
    return self.dup unless block_given?
    return self.dup if proc.nil?

    ary = []
    if proc.nil?
      to_a.my_each { |elem| ary << yield(elem) }
    else
      to_a.my_each { |elem| ary << proc.call(elem) }
    end
    ary
  end


  def my_none?
          return nil unless block_given?

          my_each do |elem|
            return false if yield elem
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

      def my_inject(arg = nil, sim = nil)
        if block_given?
          acc = arg
          my_each do |i| acc = acc.nil? ? i : yield(acc, i) end
          acc
        elsif !arg.nil? && arg.is_a?(Symbol)
          acc = nil
          my_each do |i| acc = acc.nil? ? i : acc.send(arg, i) end
          acc
        elsif !sim.nil? && sim.is_a?(Symbol)
          acc = arg
          my_each do |i| acc = acc.nil? ? i : acc.send(sim, i) end
          acc
        else
          yield
        end
      end
    end
    def multiply_els(array)
  array.my_inject(:*)
end
