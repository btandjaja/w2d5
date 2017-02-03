require_relative 'hashes'

class HashSet

  def initialize
    @num_elements = 0
    @num_buckets = 2
    @store = Array.new(2) { [] }
  end

  def inspect
    p @store
    nil
  end

  def insert(element)
    return if bucket(element).include?(element)

    @num_elements += 1
    resize(2) if @num_buckets <= @num_elements
    bucket(element) << element
  end

  def remove(element)
    return unless bucket(element).include?(element)

    @num_elements -= 1
    resize(0.5) if @num_elements * 4 <= @num_buckets
    bucket(element).delete(element)
  end

  def include?(element)
    bucket(element).include?(element)
  end

  private

  def resize(resize_by)
    @num_buckets = (@num_buckets * resize_by).to_i
    new_store = Array.new(@num_buckets) { [] }
    @store.each do |bkt|
      bkt.each { |el| new_store[el.hash % @num_buckets] << el }
    end
    @store = new_store
  end

  def bucket(element)
    @store[element.hash % @num_buckets]
  end

end

# a = HashSet.new
# a.inspect
# a.insert(6)
# a.insert(7)
# a.insert(["rabbit", "bunny", "hare"])
# a.insert(7.3333333)
# a.insert({"e" => 7, "g" => 65})
# a.inspect
# puts ":)"
