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


# a = MaxIntSet.new(5)
#
# p a.insert(2)
# # p a.insert(5)
# p a.include?(2)
# p a.remove(2)
