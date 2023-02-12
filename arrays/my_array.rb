# Here, class \MyArray provides methods that are useful for:
# 

class MyArray
  attr_reader :length

  def initialize
    @length = 0
    @elements = Hash.new
  end

  def inspect
    @elements
  end

  def [](index)
    @elements[index]
  end
  alias slice []
  
  def []=(index, element)
    while index > @length
      @elements[@length] = nil
      @length += 1
    end
    @elements[index] = element
    @length += 1
  end
  
  def push(element)
    @elements[@length] = element
    @length += 1
    return @elements
  end

  def pop
    latest_element = @elements[@length -1]
    @elements.delete(@length -1)
    @length -= 1

    return latest_element
  end

  def delete_at(index)
    if index < @length
      element = @elements[index]
      
      self.shift_elements(index)
      return element
    else
      return nil
    end
  end

  def delete(element)
    @elements.each_value.with_index do |value, index|
      if value == element
        self.shift_elements(index)
        return value
      end
    end
    
    return nil
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
end
