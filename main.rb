# rubocop: disable Metrics/ModuleLength
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
    if !args.nil? && !args.is_a?(Class)
      if args.is_a?(Regexp)
        my_each { |i| return false unless !i[args].nil? || i[args] == 1 }
      else
        my_each { |i| return false unless i == args }
      end
    elsif args.is_a?(Class)
      my_each { |i| return false unless i.is_a?(args) }
    elsif args.nil? && block_given?
      my_each { |i| return false unless yield i }
    else
      my_each { |i| return false if i.nil? || i == false }
    end
    true
  end

  def my_map(proc = nil)
    return to_enum(:my_map) if proc.nil? && !block_given?

    ary = []
    if proc.nil?
      my_each_with_index { |i, j| ary[j] = yield i }
    else
      my_each_with_index { |i, j| ary[j] = proc.call(i) }
    end
    new_array
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

  def my_none?(args = nil)
    return true if self == [] || nil?

    if !block_given? && args.nil?
      my_each { |i| return false if !i.nil? && i != false }
    elsif args.is_a?(Regexp)
      my_each { |i| return false if i.to_s =~ args }
    elsif args.is_a?(Class)
      my_each { |i| return false if i.is_a?(args) }
    elsif !args.is_a?(Class) && !block_given?
      my_each { |i| return false if i == args }
    elsif block_given?
      my_each { |i| return false if yield i }
    end
    true
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
    raise TypeError, "#{arg} is not a symbol/string" if arg.is_a?(Integer) && sim.nil? && !block_given?

    raise LocalJumpError, 'No block Given/Empty Argument' if arg.nil? && sim.nil? && !block_given?

    memo = nil
    symbol = nil
    if !arg.nil? && !sim.nil?
      memo = arg
      symbol = sim
      my_each do |i|
        memo = memo.send(symbol, i)
      end
    elsif arg.is_a? Symbol
      symbol = arg
      my_each { |i| memo = (memo ? memo.send(symbol, i) : i) }
    else
      memo = arg
      my_each { |i| memo = (memo ? yield(memo, i) : i) }
    end
    memo
  end
end

# rubocop: enable Metrics/ModuleLength
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/MethodLength
def multiply_els(array = nil)
  raise TypeError, 'No Array Given' if arg.nil? || !arg.is_a?(Array)

  array.my_inject(:*)
end
