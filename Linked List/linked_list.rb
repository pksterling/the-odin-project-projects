class LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    if @head == nil
      @head = Node.new(value, @tail)
    else
      current_node = @head
      until current_node.next_node == nil
        current_node = current_node.next_node
      end
      current_node.next_node = Node.new(value, @tail)
    end
  end

  def prepend(value)
    if @head == nil
      @head = Node.new(value, @tail)
    else
      @head = Node.new(value, @head)
    end
  end

  def size(current_node = @head, size = 0)
    if current_node == nil
      return size
    end

    size(current_node.next_node, size + 1)
  end

  def head
    @head
  end

  def tail
    if @head == nil
      return @tail
    end
    current_node = @head
    until current_node.next_node == nil
      current_node = current_node.next_node
    end
    current_node
  end

  def at(index)
    if @head == nil
      return "Node does not exist."
    end
    current_node = @head
    n = index
    n.times do
      if current_node.next_node == nil
        current_node = "Node does not exist."
        break
      end
      current_node = current_node.next_node

    end
    current_node
  end

  def pop
    if @head == nil
      return
    elsif @head.next_node == nil
      @head.next_node = nil
    else
      current_node = @head
      until current_node.next_node.next_node == nil
        current_node = current_node.next_node
      end
      current_node.next_node = nil
    end
  end

  def contains?(value)
    contains = false
    unless @head == nil
      current_node = @head
      until current_node == nil
        contains = true if current_node.value == value
        current_node = current_node.next_node
      end
    end
    contains
  end

  def find(value, current_node = @head, index = 0)
    return nil if current_node == nil
    return index if current_node.value == value
    return find(value, current_node.next_node, index + 1)
  end

  def to_s(current_node = @head, string = "")
    if current_node == nil
      puts string + "nil"
      return
    end

    to_s(current_node.next_node, "#{string}( #{current_node.value} ) -> ")
  end

  def insert_at(value, index, counter = 0, current_node = @head)
    if index == 0
      @head = Node.new(value, @head)
    elsif @head != nil
      if counter == index - 1
        current_node.next_node = Node.new(value, current_node.next_node)
      elsif counter == index - 2 && current_node.next_node == nil
        p "Index does not exist"
      elsif counter < index - 1
        insert_at(value, index, counter + 1, current_node.next_node)
      end
    else
      p "Index does not exist"
    end
  end


  class Node
    attr_accessor :value, :next_node

    def initialize(value, next_node)
      @value = value
      @next_node = next_node
    end
  end
end

list = LinkedList.new
# list.append(5)
# list.append(12)
# list.prepend(19)
# list.prepend(10)
p list.size
p list.head
p list.tail
p list.at(3)
p list.contains?(12)
list.pop
p list.contains?(12)
p list.find(10)
list.insert_at(3, 1)
list.to_s

