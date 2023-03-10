# #
# This library provides the MyArray class, which deals with a collection
# of ordered values. It is a hybrid of the Array and Hash classes.
# 
# MyArray uses Hash as storage.
# 
# ## Example
#
# ```ruby
# require 'my_array'
# m1 = MyArray[]                    #=> #<MyArray: []>
# m2 = MyArray[1, 2, "foo"]         #=> #<MyArray: [1, 2, "foo"]>
# m2.push("bar")                    #=> #<MyArray: [1, 2, "foo", "bar"]>
# 
# ## What's here
# 
#  First, what's elsewhere. \Class \MyArray:
# 
# - Inherits from {class Object}.
# - Includes {module Enumerable}, which provides dozens of additional
#   methods.
# 
# In particular, class \MyArray doesn't have any methods of its own for
# fetching or iterating. Instead, it relies on those in \Enumerable.
# 
# ## Here, class \MyArray provides methods that are useful for:
# 
# ### Methods for Creating a \MyArray
# 
# - ::[]:
#   Return a new MyArray containing the given objects.
# - ::new:
#   Return a new MyArray containing the given objects.
# 
# ### Methods for Querying
# 
# - \#length:
#   Returns the count of elements.
# - \#empty?:
#   Returns whether the collection has no elements.
#
# ### Methods for Assigning/Inserting
# 
# - \[]=:
#   Assign/Reassign an element at an arbitrary location of the
#   collection; returns the assigned element.
# - \#push (aliased as #<<):
#   Adds an element at the end of the collection; returns +self+.
# - \#unshift:
#   Adds an element at the beginning of the collection; returns
#   +self+.
# - \#insert:
#   Adds an element at an arbitrary location of the collection;
#   Returns +self+.
# 
# ### Methods for Searching/Reading
# 
# - \#[] (aliased as #slice):
#   Returns the element at the given index.
# - \#find_index:
#   Returns the position (index) of the given value.
# 
# ### Methods for Deleting
# 
# - \#shift:
#   Removes an element from the beginning of the collection; returns
#   the deleted element.
# - \#delete_at:
#   Removes an element from an arbitrary location of the collection;
#   returns the deleted element.
# - \#pop:
#   Removes last element of the collection; returns the deleted element.
# - \#delete:
#   Removes an element from an arbitrary location by its value; returns
#   the deleted element.
# 
# ### Methods for Iterating
#
# - \#each:
#   Calls the block with each successive element; returns +self+.
# 
# ### Other Methods
# 
# - \#reverse:
#   Reverse collection's elements order.
# - \#reverse!:
#   Reverse collection's elements order in place.
# 

require '../algorithms/search'

class MyArray
  include Enumerable
  
  attr_reader :length

  # Creates a new MyArray containing the given objects.
  # 
  # MyArray['foo', 2]             #=> #<MyArray: ['foo', 2]>
  # MyArray['foo', true, 'bar]    #=> #<MyArray: ['foo', true, 'bar']>
  def self.[](*ary)
    new(ary)
  end

  # Creates a new MyArray containing the elements of the given collection
  # object
  def initialize(enum = nil)
    @length = 0
    @elements = Hash.new(nil)

    return if enum.nil?

    enum.each do |val|
      @elements[@length] = val
      @length += 1
    end
  end

  # Calls the given block once for each element in the collection, passing
  # the element as a parameter. Return an enumerator if no block is given.
  def each
    return self.enum_for(__method__) unless block_given?

    counter = 0
    while counter < @length
      yield @elements[counter]
      counter += 1
    end

    return self
  end

  # Returns the element at the given index.
  def [](index)
    @elements[index]
  end
  
  alias slice []

  # Returns the position (index) of the given value.
  # Time Complexity => O(n)
  def find_index(value)
    self.each.with_index do |element, index|
      return index if element == value
    end

    return nil
  end
  
  def []=(index, element)
    while index > @length
      @elements[@length] = nil
      @length += 1
    end
    @elements[index] = element
    @length += 1 if index == @length
  end
  
  # Constant Time to add element to the end of collection if size
  # isn't equal capacity, otherwise Linear Time.
  # Time Complexity => best case O(1) or worst case O(n)
  def push(element)
    @elements[@length] = element
    @length += 1
    return self
  end

  alias << push

  # Linear time to add at the beginning of collection.
  # Moves other values. Time Complexity => O(n)
  def unshift(value)
    self.unshift_elements(0, value)
    return self
  end

  # Linear time to add at an arbitrary location of collection.
  # Moves other values. Time Complexity => O(n)
  def insert(index, value)
    abs_index = index.abs
    while abs_index > @length
      @elements[@length] = nil
      @length += 1
    end
    
    self.unshift_elements(abs_index, value)
    return self
  end

  # Constant time to remove last element. Time Complexity => O(1)
  def pop
    latest_element = @elements[@length -1]
    @elements.delete(@length -1)
    @length -= 1

    return latest_element
  end

  # Linear time to remove at the beginning of the collection.
  # Shifts other values. Time Complexity O(n)
  def shift
    first_element = @elements[0]
    self.shift_elements(0)
    return first_element
  end

  # Linear time to remove at an arbitrary location. Shifts other values.
  # Time Complexity O(n)
  def delete_at(index)
    if index < @length
      element = @elements[index]
      
      self.shift_elements(index)
      return element
    else
      return nil
    end
  end

  # Linear time to remove at an arbitrary location. Shifts other values.
  # Time Complexity O(n)
  def delete(element)
    self.each.with_index do |value, index|
      if value == element
        self.shift_elements(index)
        return value
      end
    end
    
    return nil
  end

  # Returns true if the collection has no elements.
  def empty?
    @length == 0
  end

  # Return collection with elements' order reversed.
  def reverse
    return self if @length <= 1
    
    reversed = MyArray[]
    self.each { |value| reversed.unshift(value) }
    return reversed
  end

  def reverse!
    return self if @length <= 1

    left_pointer = 0
    right_pointer = @length - 1
    while left_pointer < right_pointer
      @elements[left_pointer], @elements[right_pointer] = @elements[right_pointer], @elements[left_pointer]
      
      left_pointer += 1
      right_pointer -= 1
    end

    return self
  end

  # Returns a string containing a human-readable representation of the
  # collection ("#<MyArray: [element1, element2, ...]>").
  def inspect
    sprintf('#<%s: [%s]>', self.class, @elements.values.inspect[1..-2])
  end

  alias to_s inspect

  def pretty_print(pp)  # :nodoc:
    pp.group(1, sprintf('#<%s:', self.class.name), '>') {
      pp.breakable
      pp.group(1, '[', ']') {
        pp.seplist(self) { |o|
          pp.pp o
        }
      }
    }
  end

  private

  def shift_elements(index)
    counter = index
    while counter < (@length - 1)
      @elements[counter] = @elements[counter + 1]
      counter += 1
    end
    @elements.delete(@length - 1)
    @length -= 1
  end

  def unshift_elements(index, value)
    counter = @length - 1
    while counter >= index
      @elements[counter + 1] = @elements[counter]
      counter -= 1
    end
    @elements[index] = value
    @length += 1
  end
end
