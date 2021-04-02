module Enumerable
      def my_each
        a = 0
        return to_enum unless block_given?
    
        while to_a.length > a
          yield(to_a[a])
          a += 1
        end
        self
      end
  end