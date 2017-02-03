class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "{#{@key}: #{@val}}"
  end

  def remove
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList

  include Enumerable

  attr_reader :count

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
    @count = 0
  end

  def to_s
    map { |link| link.to_s }.join(" -> ")
  end

  def empty?
    @head.next == @tail
  end

  def first
    raise "LinkedList is empty!" if empty?
    @head.next
  end

  def last
    raise "LinkedList is empty!" if empty?
    @tail.prev
  end

  def [](index)
    i, curr_link = 0, @head
    until i == index
      curr_link = curr_link.next
      raise "index not in list!" if curr_link == @tail
      i += 1
    end
    curr_link.next
  end

  def append(key, val)
    link = Link.new(key, val)
    curr_link = @head

    until curr_link.next == @tail
      curr_link = curr_link.next
      if curr_link.key == key
        curr_link.val = val
        return
      end
    end

    curr_link.next = link
    link.prev = curr_link
    link.next = @tail
    @tail.prev = link
    @count += 1

    link
  end

  def update(key, val)
    each { |link| link.val = val if link.key == key }
    nil
  end

  def get(key)
    each { |link| return link.val if link.key == key }
    nil
  end

  def remove(key)
    throw "LinkedList is empty!" if empty?
    each do |link|
      if link.key == key
        link.remove
        @count -= 1
        return
      end
    end
    nil
  end

  def include?(key)
    each { |link| return true if link.key == key }
    false
  end

  def each(&prc)
    curr_link = @head

    until curr_link.next == @tail
      curr_link = curr_link.next
      prc.call(curr_link)
    end

    nil
  end

end

# my_linked_list = LinkedList.new
#
# p my_linked_list.empty?
#
# my_linked_list.append("q", 4)
# my_linked_list.append("r", 100)
# my_linked_list.append("s", 13)
# my_linked_list.append("t", 6)
#
# puts my_linked_list.to_s

# p my_linked_list.first
# my_linked_list.update("q", 15)
# p my_linked_list.first
#
# p my_linked_list.include?("r")
# my_linked_list.remove("r")
# p my_linked_list.include?("r")
#
# p my_linked_list.get("s")
#
# p my_linked_list.map { |link| "#{link.key} => #{link.val}" }
