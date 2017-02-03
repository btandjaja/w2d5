class LRUCache
  def add element
    include_element = @stack.include?(element)
    unless include_element
      @stack.shift if @stack.length == @size
    else
      index = @stack.find_index(element)
      @stack.delete_at(index)
    end
    @stack << element
  end

  def count
    p @stack.length
  end

  def show
    p @stack
  end

  private
  def initialize size
    @size = size
    @stack = []
  end
end

johnny_cache = LRUCache.new(4)

johnny_cache.add("I walk the line")
johnny_cache.add(5)

johnny_cache.count # => returns 2

johnny_cache.add([1,2,3])
johnny_cache.add(5)
johnny_cache.add(-5)
johnny_cache.add({a: 1, b: 2, c: 3})
johnny_cache.add([1,2,3,4])
johnny_cache.add("I walk the line")
johnny_cache.add(:ring_of_fire)
johnny_cache.add("I walk the line")
johnny_cache.add({a: 1, b: 2, c: 3})
johnny_cache.show
