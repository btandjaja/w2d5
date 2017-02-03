require_relative 'LinkedList'
require_relative 'HashMap'

class LRUCache

  def initialize(max_size, &prc)
    @max_size = max_size
    @prc = prc
    @store = LinkedList.new
    @links_map = HashMap.new
  end

  def count
    @links_map.count
  end

  def get(key)
    if @links_map.include?(key)
      this_link = @links_map[key]

      @store.remove(this_link.key)
      @store.append(this_link.key, this_link.val)

      this_link.val
    else
      result = @prc.call(key)

      new_link = @store.append(key, result)
      @links_map[key] = new_link

      if @store.count > @max_size
        deleted_key = @store.first.key
        @store.remove(deleted_key)
        @links_map.delete(deleted_key)
      end

      result
    end
  end

  def to_s
    "Map: " + @links_map.to_s + "\n" + "Store: " + @store.to_s
  end

end

squares = LRUCache.new(5) { |x| x ** 2 }
squares.get(3)
squares.get(5)
squares.get(17)
squares.get(23)
squares.get(-4)
squares.get(10)
squares.get(17)

puts squares.to_s
