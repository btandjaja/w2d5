class ResizingIntSet

  def initialize
    @num_elements = 0
    @num_buckets = 2
    @store = Array.new(2) { [] }
  end

  def inspect
    @store
  end

  def insert element
    this_bucket = @store[element % @num_buckets]
    this_bucket << element unless this_bucket.include?(element)


    resize
  end

  def remove element
  end

  def include? element
    @store[element % @num_buckets].include?(element)
  end

  private

  def resize
    if @num_buckets <= @num_elements
      @num_buckets *= 2
      new_store = Array.new(@num_buckets) { [] }
      @store.each do |bucket|
        bucket.each { |el| new_store[el % @num_buckets] << el }
      end
      @store = new_store
    end
  end

end
