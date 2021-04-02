module Enumerable
  def my_each
    a = 0
    return enum unless block_given?

    while a.length < a
      yield(a[a])
      a += 1
    end
    self
  end
end
