
module Search
  # Minimum/lower bound implementation of Binary Search.
  # Returns the index of the first element that meets the given condition
  # (block given) in log(n) time provided the array is sorted, but this
  # is not checked. Returns nil if no element meets the condition.
  def self.bsearch(array)
    left, right = 0, array.length

    while left < right
      mid = (left + right) / 2

      if yield(array[mid])
        right = mid
      else
        left = mid + 1
      end
    end

    return left == array.length ? nil : left
  end

  # Minimum/lower bound implementation of Binary Search as described at
  # method #bsearch, but makes use of recursion instead of using a loop.
  def self.bsearch_rec(array, left, right, &block)
    if left >= right
      return left == array.length ? nil : left
    else
      mid = (left + right) / 2
      
      if yield(array[mid])
        self.bsearch_rec(array, left, mid, &block)
      else
        self.bsearch_rec(array, mid + 1, right, &block)
      end
    end
  end
  
  # Standard Binary Search: This search returns the index of an item in log(n)
  # time provided the array is sorted. The mehod returns nil if item
  # is not found.
  def self.binary_search(array, item)
    lower_bound = 0
    upper_bound = array.length - 1

    while lower_bound <= upper_bound
      midpoint = (upper_bound + lower_bound) / 2
      value = array[midpoint]

      if item == value
        return midpoint
      elsif item < value
        upper_bound = midpoint - 1
      elsif item > value
        lower_bound = midpoint + 1
      end
    end

    return nil
  end

  # Standard Binary Search as described at method #binary_search but
  # using recursion. Returns the index of an item in log(n) time provided
  # the array is sorted. The mehod returns nil if item is not found.
  def self.rec_binary_search(array, item, min, max)
    if max < min
      return nil
    else
      midpoint = (min + max) / 2

      if item == array[midpoint]
        return midpoint
      elsif item < array[midpoint]
        rec_binary_search(array, item, min, midpoint - 1)
      elsif item > array[midpoint]
        rec_binary_search(array, item, midpoint + 1, max)
      end
    end
  end
end
