class DynamicArray

  include Enumerable

  attr_reader :capacity

  def initialize(capacity)
    @capacity = capacity
    @store = Hash.new
    @element_count = 0
    @shift_by = 0
  end

  def to_s
    stringified = (@shift_by...@capacity + @shift_by).map { |i| @store.key?(i) ? @store[i] : "nil" }
    "[#{ stringified.join(", ")}]"
  end

  def [](index)
    @store[(index < 0 ? @element_count + index : index) + @shift_by]
  end

  def []=(index, element)
    pos_index = index < 0 ? @element_count + index : index

    @element_count += @store[pos_index + @shift_by].nil? ? 1 : 0
    @store[pos_index + @shift_by] = element
  end

  def push(element)
    resize! if @element_count == @capacity

    @store[@element_count + @shift_by] = element
    @element_count += 1
  end

  def count
    @element_count
  end

  def unshift(element)
    resize! if @element_count == @capacity

    # shifted = @store[0]
    # (1..@element_count).to_a.each do |i|
    #   @store[i], shifted = shifted, @store[i]
    # end
    #
    # @store[0] = element
    @shift_by -= 1
    @store[@shift_by] = element
    @element_count += 1
  end

  def pop
    return nil if @element_count == 0

    @element_count -= 1
    popped = @store[@element_count + @shift_by]
    @store.delete(@element_count + @shift_by)
    popped
  end

  def shift
    return nil if @element_count == 0

    shifted = @store[@shift_by]

    # (1...@element_count).to_a.each do |i|
    #   @store[i-1] = @store[i]
    # end

    @store.delete(@shift_by)
    @shift_by += 1

    @element_count -= 1
    # @store.delete(@element_count)

    shifted
  end

  def first
    # @store[0]
    @store[@shift_by]
  end

  def last
    self[-1]
  end

  def each(&prc)
    @element_count.times do |i|
      prc.call(@store[i + @shift_by])
    end
  end

  def include?(element)
    each { |el| return true if el == element }
    false
  end

  def ==(inp)
    return false unless inp.class == Array || inp.class == DynamicArray
    each_with_index { |el, i| return false unless el == inp[i] }
    true
  end

  private

  def resize!
    @capacity *= 2
  end

end

# d = DynamicArray.new(4)
# d.push(1)
# d.push(2)
# d.push(3)
# puts d
# p d.shift
# puts d
# puts d == [2, 3, nil, nil]
# d.unshift(4)
# puts d
# d.push(5)
# puts d
# puts d == [4, 2, 3, 5]
# d.shift
# d.shift
# puts d
# puts d.include?(3)
# puts d.include?(2)
# p d.map { |el| el ** 2 }
# puts d.last
# d[2] = 4
# d[0] = 17
# puts d
