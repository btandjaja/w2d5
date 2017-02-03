class IntSet

  attr_accessor :store

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
