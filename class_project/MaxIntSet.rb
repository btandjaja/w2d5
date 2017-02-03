class MaxIntSet
  def initialize size
    @size = size
    @store = Array.new(size){false}
  end

  def insert index
    raise 'out of bounds' unless index < @size && index >= 0
    #do something
    @store[index] = true
  end

  def remove index
    raise 'out of bounds' unless index < @size && index >= 0
    @store[index] = false
    #do something
  end

  def include? index
    raise 'out of bounds' unless index < @size && index >= 0
    @store[index]
  end
end


a = MaxIntSet.new(5)

p a.insert(2)
# p a.insert(5) 
p a.include?(2)
p a.remove(2)
