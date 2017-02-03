class String

  def hash
    self.split("").map(&:ord).hash
  end

end

class Array

  def hash
    numeric_values = self.map(&:hash)
    single_value = numeric_values.each_with_index.reduce(0) { |total, (num, i)| total ^= num + i }
    single_value.hash
  end

end

class Hash

  def hash
    self.map { |k, v| [k.hash, v.hash] }.flatten.sort.hash
  end

end

# h = { "a" => [1, 2, 3], [6, "basketball"] => "terry" }
# h2 = { "a" => "b", "c" => "d" }
#
# a1 = [1, 2, 3, 4, 5, 6]
# a2 = ["c", "cat", "airplane"]
# a3 = [3, "tyrant", 17, "pasta", [4, 6, 2]]
#
# p a1.hash
# p a2.hash
# p a3.hash
#
# p h.hash
# p h2.hash
