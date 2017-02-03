require_relative 'LinkedList'
require_relative 'hashes'

class HashMap

  include Enumerable

  def initialize
    @num_elements = 0
    @num_buckets = 2
    @store = Array.new(2) { LinkedList.new }
  end

  def set(key, val)
    @num_elements -= 1 if bucket(key).include?(key)
    bucket(key).append(key, val)
    @num_elements += 1

    resize(2) if @num_buckets <= @num_elements
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    return unless bucket(key).include?(key)

    bucket(key).remove(key)
    @num_elements -= 1

    resize(0.5) if @num_elements * 4 <= @num_buckets
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def [](key)
    get(key)
  end

  def []=(key, value)
    set(key, value)
  end

  def each(&prc)
    @store.each do |linked_list|
      linked_list.each { |link| prc.call(link) }
    end
  end

  def to_s
    "{ #{map { |link| link.to_s }.join("\n")} }"
  end

  private

  def resize(resize_by)
    @num_buckets = (@num_buckets * resize_by).to_i
    new_store = Array.new(@num_buckets) { LinkedList.new }

    @store.each do |bkt|
      bkt.each { |link| new_store[link.key.hash % @num_buckets].append(link.key, link.val) }
    end

    @store = new_store
  end

  def bucket(key)
    @store[key.hash % @num_buckets]
  end

end

# h = HashMap.new
# h.set("t", 6)
# h.set(76, 23)
# h.set([1, 4, 9], 17)
# h.set("w", 5)
# h.set({:a => 8}, 36)
# h.set("y", [54, [1, 2]])
# puts h.to_s

# h.each { |k, v| puts "#{k} => #{v}" }
#
# p h.include?([1, 4, 9])
# h.delete([1, 4, 9])
# p h.include?([1, 4, 9])
# h.each { |k, v| puts "#{k} => #{v}" }
#
# p h.get("w")
