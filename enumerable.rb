module Enumerable
  def my_each
    i = 0
    return enum unless block_given?

    while to_a.length > i
      yield(to_a[i])
      i += 1
    end
    self
  end
end
["Brian", "Susan", "Mandy", "John"].my_each {|friend| puts friend }