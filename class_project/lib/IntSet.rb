class MaxIntSet
  def initialize size
    @size = size
    @store = Array.new(size) {false}
  end

  def insert index
    check_validity
    @store[index] = true
  end

  def remove index
    check_validity
    @store[index] = false
    index
  end

  def include? index
    check_validity
    @store[index]
  end

  private

  def check_validity
    raise 'out of bounds' unless index < @size && index >= 0
  end
end



class IntSet

  def initialize
    @store = Array.new(20) { [] }
  end

  def insert element
    @store[element % 20] << element unless @store[element % 20].include?(element)
  end

  def remove element
    @store[element % 20].delete(element)
  end

  def include? element
    @store[element % 20].include?(element)
  end

end



class ResizingIntSet

  def initialize
    @num_elements = 0
    @num_buckets = 2
    @store = Array.new(2) { [] }
  end

  def inspect
    p @store
    nil
  end

  def insert element
    return if bucket(element).include?(element)

    @num_elements += 1
    resize(2) if @num_buckets <= @num_elements
    bucket(element) << element
  end

  def remove element
    return unless bucket(element).include?(element)

    @num_elements -= 1
    resize(0.5) if @num_elements * 4 <= @num_buckets
    bucket(element).delete(element)
  end

  def include? element
    bucket(element).include?(element)
  end

  private

  def resize(resize_by)
    @num_buckets = (@num_buckets * resize_by).to_i
    new_store = Array.new(@num_buckets) { [] }
    @store.each do |bkt|
      bkt.each { |el| new_store[el % @num_buckets] << el }
    end
    @store = new_store
  end

  def bucket(element)
    @store[element % @num_buckets]
  end

end
