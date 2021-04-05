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


  def my_each_with_index
    i = 0
    return enum unless block_given?

    while to_a.length > i
      yield(to_a[i], i)
      i += 1
    end
    self
  end
["Brian", "Susan", "Mandy", "John"].my_each {|friend| puts friend }

def my_select
  new_array = []
  return enum unless block_given?

  to_a.my_each { |item| new_array.push(item) if yield(item) }
  new_array
end
["Brian", "Susan", "Mandy", "John"].my_each {|friend| puts friend }