class DynamicArray

  include Enumerable

  attr_reader :capacity

  def initialize(capacity)
    @capacity = capacity
    @store = Hash.new
    @element_count = 0
  end

  def to_s
    stringified = (0...@capacity).map { |i| @store.key?(i) ? @store[i] : "nil" }
    "[#{ stringified.join(", ")}]"
  end

  def [](index)
    @store[index < 0 ? @element_count + index : index]
  end

  def []=(index, element)
    pos_index = index < 0 ? @element_count + index : index

    @element_count += @store[pos_index].nil? ? 1 : 0
    @store[pos_index] = element
  end

  def push(element)
    resize! if @element_count == @capacity

    @store[@element_count] = element
    @element_count += 1
  end

  def count
    @element_count
  end

  def unshift(element)
    resize! if @element_count == @capacity

    shifted = @store[0]
    (1..@element_count).to_a.each do |i|
      @store[i], shifted = shifted, @store[i]
    end

    @store[0] = element
    @element_count += 1
  end

  def pop
    return nil if @element_count == 0

    @element_count -= 1
    popped = @store[@element_count]
    @store.delete(@element_count)
    popped
  end

  def shift
    return nil if @element_count == 0

    shifted = @store[0]

    (1...@element_count).to_a.each do |i|
      @store[i-1] = @store[i]
    end

    @element_count -= 1
    @store.delete(@element_count)

    shifted
  end

  def first
    @store[0]
  end

  def last
    self[-1]
  end

  def each(&prc)
    @element_count.times do |i|
      prc.call(@store[i])
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
