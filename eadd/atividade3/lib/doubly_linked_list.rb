class DoublyLinkedList
  attr_accessor :head, :tail, :length
  
  def initialize()
    @head = nil
    @tail = nil
    @length = 0
  end

  def push(val)
    new_node = Node.new(val)
    
    if @length == 0
      @head = new_node
      @tail = new_node
    else 
      @tail.next = new_node
      new_node.prev = @tail
      @tail = new_node
    end
    
    @length += 1
    self
  end

  def pop
    return nil if !@head
    
    old_tail = @tail
    
    if @length == 1
      @head = nil
      @tail = nil
    else 
      @tail = old_tail.prev
      new_tail.next = nil
      old_tail.prev = nil 
    end
    
    @length -= 1
    old_tail
  end

  def shift
    return nil if !@head
    
    old_head = @head
    
    if @length == 1
      @head = nil
      @tail = nil
    else 
      @head = old_head.next
      @head.prev = nil
      old_head.next = nil 
    end
    
    @length -= 1
    old_head
  end

  def unshift(val)
    new_node = Node.new(val)
    
    if @length == 0 
      @head = new_node
      @tail = new_node
    else 
      @head.prev = new_node
      new_node.next = @head
      @head = new_node
    end
    
    @length += 1
    self
  end

  def [](index)
    return nil if index < 0 || index >= @length
    
    if index <= @length / 2
      i = 0
      current = @head
      while i < index do
        current = current.next
        i += 1
      end
    else 
      i = @length - 1
      current = @tail
      while i > index do
        current =  current.prev
        i -= 1
      end
    end
    
    current
  end

  def []=(index, val) 
    node = self[index]
    
    if !!node 
      node.val = val
      true
    else 
      false
    end
  end

  def insert_sorted(val)
    return !!push(val) if @length == 0
    return !!push(val) if self[@length - 1].val <= val

    new_node = Node.new(val)
    current_node = @head
    
    while current_node
      if val < current_node.val
        current_node.prev.next = new_node if current_node.prev

        new_node.next = current_node
        new_node.prev = current_node.prev
        current_node.prev = new_node
        
        @head = new_node if @head == current_node
        
        break
      end

      current_node = current_node.next
    end
    
    @length += 1
    true
  end

  def insert(index, val)
    return false if index < 0 || index > @length
    return !!unshift(val) if index == 0
    return !!push(val) if index == @length
    
    new_node = Node.new(val)
    prev_node = [index - 1]
    after_new_node = prev_node.next
    new_node.prev = prev_node
    new_node.next = after_new_node
    prev_node.next = new_node
    after_new_node.prev = new_node
    @length += 1 
    true
  end

  def remove(index) 
    return nil if index < 0 || index >= @length
    return shift() if index == 0
    return pop() if index == @length - 1
    
    removed_node = [index]
    prev_node = removed_node.prev
    next_node = removed_node.next
    prev_node.next = next_node
    next_node.prev = prev_node
    removed_node.next = nil
    removed_node.prev = nil
    @length -= 1
    removed_node
  end

  def reverse
    return self if @length < 2
    
    node = @head
    @head = @tail
    @tail = node
    
    i = 0
    while i < @length do
      prev = node.next
      node.next = node.prev
      node.prev = prev
      node = prev
      i += 1
    end
    
    self
  end

  def print_node_vals
    node = @head
    
    while node
      print node.val
      print " <-> " if node.next
      node = node.next
    end

    print "\n"
  end

  def sequential_search(val)
    i = 0
    node = @head
    
    while node
      return i if node.val == val
      node = node.next
      i += 1
    end
    
    -1
  end

  def binary_search(val)
    first = 0
    last = @length - 1

    while first <= last
        i = (first + last) / 2

        if self[i].val == val
            return i
        elsif self[i].val > val
            last = i - 1
        else
            first = i + 1
        end
    end
    
    -1
  end
end