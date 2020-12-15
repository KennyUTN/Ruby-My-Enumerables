# rubocop: disable Metrics/ModuleLength, Style/ConditionalAssignment
# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/MethodLength
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

    ary = []
    my_each do |elem|
      ary << elem if yield elem
    end
    ary
  end

  def my_all?
    flag = 0
    self.class == Hash || self.class == Range ? arr = to_a : arr = self
    case args.empty?
    when true
      if block_given?
        arr.my_each do |i|
          break if yield(i).nil? || yield(i) == false

          flag += 1 if yield(i) != false || yield(i).nil?
        end
      else
        arr.my_each { |i| flag += 1 unless i.nil? || i == false }
      end
    when false
      if args[0].class == Regexp
        arr.my_each { |itr| flag += 1 if itr =~ args[0] }
      elsif args[0].class == Class
        arr.my_each { |itr| flag += 1 if itr.is_a?(args[0]) }
      else
        arr.my_each { |itr| flag += 1 if args[0] == itr }
      end
    end
    flag == size
  end

  def my_map(proc = nil)
    return dup unless block_given?
    return dup if proc.nil?

    ary = []
    if proc.nil?
      to_a.my_each { |elem| ary << yield(elem) }
    else
      to_a.my_each { |elem| ary << proc.call(elem) }
    end
    ary
  end

  def my_any?
    flag = 0
    case args.empty?
    when true
      if block_given?
        my_each do |i|
          flag += 1 if block.call(i)
        end
      else
        my_each do |i|
          flag += 1 unless i.nil? || i == false
        end
      end
    when false
      if args[0].class == Regexp
        my_each do |itr|
          flag += 1 if itr =~ args[0]
        end
      elsif args[0].class == Class
        my_each do |itr|
          flag += 1 if itr.is_a?(args[0])
        end
      else
        my_each do |itr|
          flag += 1 if args[0] == itr
        end
      end
    end
    flag.positive?
  end

  def my_none?
    !my_any?(*args, &block)
  end

  def my_count(*arg)
    n = 0
    case !block_given?
    when true
      if arg.empty?
        size
      else
        my_each { |i| n += 1 if arg[0] == i }
        n
      end
    when false
      my_each { |i| n += 1 if yield(i) == true }
      n
    end
  end

  def my_inject(arg = nil, sim = nil)
    if block_given?
      acc = arg
      my_each { |i| acc = acc.nil? ? i : yield(acc, i) }
      acc
    elsif !arg.nil? && arg.is_a?(Symbol)
      acc = nil
      my_each { |i| acc = acc.nil? ? i : acc.send(arg, i) }
      acc
    elsif !sim.nil? && sim.is_a?(Symbol)
      acc = arg
      my_each { |i| acc = acc.nil? ? i : acc.send(sim, i) }
      acc
    else
      yield
    end
  end
end

# rubocop: enable Metrics/ModuleLength, Style/ConditionalAssignment
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/MethodLength
def multiply_els(array)
  array.my_inject(:*)
end
