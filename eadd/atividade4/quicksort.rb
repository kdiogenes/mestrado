module Quicksort
  def self.partition(input, low, high)
    i = low
    j = high
    pivot = input[(low + high) / 2]
    
    while i <= j
      i += 1 while input[i] < pivot
      j -= 1 while input[j] > pivot

      if i <= j
        input[i], input[j] = input[j], input[i]
        i += 1
        j -= 1
      end
    end

    i
  end

  class Recursive
    def sort(input, low, high)
      if low < high
        pi = Quicksort.partition(input, low, high)
        sort(input, low, pi - 1)
        sort(input, pi, high)
      end
    end
  end

  class Iterative
    def sort(input, low, high)
      stack = []
      stack.push(low)
      stack.push(high)

      while stack.any?
        h = stack.pop
        l = stack.pop
        pi = Quicksort.partition(input, l, h)

        if pi - 1 > l
          stack.push(l)
          stack.push(pi - 1)
        end

        if pi < h
          stack.push(pi)
          stack.push(h)
        end
      end
    end
  end
end