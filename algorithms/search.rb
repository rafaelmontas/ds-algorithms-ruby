
module Search
  # Binary Search: This search returns the index of an item in log(n)
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

  # This method implements Binary Search using recursion
  # The mehod returns nil if item is not found
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
