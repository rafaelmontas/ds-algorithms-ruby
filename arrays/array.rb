# Practicing using Ruby arrays

def array_test
  arr = [3, 2, 5, 7, 1]

  # Array Operations
  # READ
  puts arr
  puts "Value at index 3: #{arr[3]}" # Constant time access to any element (Random access). Time Complexity => O(1)

  # SEARCH
  puts "Index of 5: #{arr.find_index(5)}" # Linear time. Time Complexity => O(N)

  # INSERT
  arr.push(9) # Constant time if size isn't equal capacity, otherwise Linear time. Time Complexity => best case O(1) or worst case O(n)
  puts "Added 9 at the end of array: #{arr}"

  # Linear time to add at an arbitrary location. Shifts other values. Time Complexity => O(n)
  arr.unshift(15)
  arr.insert(3, 8)
  puts "Added 15 at the begining and 8 at index 3 of array: #{arr}"

  # DELETE
  arr.pop() # Cosntant time to remove last element. Time Complexity => O(1)
  puts "Removed last element: #{arr}"

  # Linear time to remove at an arbitrary location. Shifts other values. TIme Complexity O(n)
  arr.shift()
  arr.delete_at(6)
  puts "Deleted first value and value at index 6: #{arr}"

  # OTHERS
  arr.reverse!
  puts "Reversed in place: #{arr}"

  arr.sort!
  puts "Sorted in place: #{arr}"
end

array_test()