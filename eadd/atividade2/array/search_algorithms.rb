class Array
  def sequential_search(n)
    i = 0
    
    while i < self.length
      return i if self[i] == n
      i += 1
    end
    
    -1
  end
  
  def optimized_sequential_search(n)
    i = 0

    while i < self.length && self[i] <= n
      return i if self[i] == n
      i += 1
    end

    -1
  end
  
  def jump_search(n)
    step = Math.sqrt(self.length).to_i

    # Finding the block where element is
    # present (if it is present)
    prev = 0;
    while self[[step, self.length].min - 1] < n
      prev = step.dup
      step += Math.sqrt(self.length).to_i
      return -1 if prev >= self.length
    end

    # Doing a linear search for n in block
    # beginning with prev.
    while self[prev] < n
      prev += 1
      # If we reached next block or end of
      # array, element is not present.
      return -1 if prev == [step, self.length].min
    end

    return prev if self[prev] == n

    -1
  end
  
  def binary_search(n)
    first = 0
    last = self.length - 1

    while first <= last
        i = (first + last) / 2

        if self[i] == n
            return i
        elsif self[i] > n
            last = i - 1
        else
            first = i + 1
        end
    end
    
    -1
  end
end
