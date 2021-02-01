class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other_node)
    @data <=> other_node.data
  end
end

class Tree
  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    return nil if array == []

    array.sort!.uniq!
    middle_index = array.length / 2

    root = array.delete_at(middle_index)
    left = build_tree(array[..middle_index - 1])
    right = build_tree(array[middle_index..])

    Node.new(root, left, right)
  end

  def insert(input, root = @root)
    input = input.is_a?(Integer) ? Node.new(input) : input
    
    return input if root.nil?

    if input < root
      root.left = insert(input, root.left)
    elsif input > root
      root.right = insert(input, root.right)
    end

    root
  end

  def delete(input, root = @root)
    input = input.is_a?(Integer) ? Node.new(input) : input

    if input == root
      if root.left.nil? && root.right.nil?
        return nil 
      elsif root.left.is_a?(Node) && root.right.nil?
        return root.left 
      elsif root.left.nil? && root.right.is_a?(Node)
        return root.right
      elsif root.left.is_a?(Node) && root.right.is_a?(Node)
        new_root = root
        until new_root.right.right.nil?
          new_root = new_root.right
        end

        root.data = new_root.right.data
        new_root.right = new_root.right.left
        return root
      end
    end

    if input < root
      root.left = delete(input, root.left)
    elsif input > root
      root.right = delete(input, root.right)
    end

    root
  end

  def find(input, root = @root)
    input = input.is_a?(Integer) ? Node.new(input) : input

    if root.nil? || input == root
      root
    elsif input < root
      find(input, root.left)
    elsif input > root
      find(input, root.right)
    end
  end

  def level_order(queue = [@root], result = [])
    return result if queue == []
    next_up = []

    queue.each do |node|
      result << node.data
      next_up << node.left unless node.left.nil?
      next_up << node.right unless node.right.nil?
    end

    level_order(next_up, result)
  end

  def inorder(root = @root, result = [])
    return result if root.nil?

    result = inorder(root.left, result)
    result << root.data 
    result = inorder(root.right, result)

    result
  end

  def preorder(root = @root, result = [])
    return result if root.nil?

    result << root.data
    result = preorder(root.left, result)
    result = preorder(root.right, result)

    result
  end

  def postorder(root = @root, result = [])
    return result if root.nil?

    result = postorder(root.left, result)
    result = postorder(root.right, result)
    result << root.data

    result
  end

  def height(node, height = 0)
    return height - 1 if node.nil?

    left_height = height(node.left, height)
    right_height = height(node.right, height)
    current_height = [left_height, right_height].max{ |a, b| a <=> b }
    
    return height + current_height + 1
  end

  def depth(node, root = @root, depth = 0)
    if root.nil? || node == root
      depth
    elsif node < root
      depth(node, root.left, depth + 1)
    elsif node > root
      depth(node, root.right, depth + 1)
    end
  end

  def balanced?(root = @root)
    (height(root.left) - height(root.right)).abs <= 1
  end

  def rebalance(root = @root)
    @root = build_tree(self.inorder)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
