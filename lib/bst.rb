class Node
  include Comparable
  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  attr_accessor :data, :left, :right

  def <=>(other)
    data <=> other.data
  end

  def no_child?
    left.nil? && right.nil?
  end

  def get_branch(branch)
    send(branch.to_sym)
  end

  def set_branch(branch, node)
    send("#{branch}=".to_sym, node)
  end

  def child_size
    size = 0
    size += 1 unless left.nil?
    size += 1 unless right.nil?

    size
  end
end

class Tree
  def self.from_arr(arr)
    Tree.new(build_tree(arr))
  end

  def initialize(root)
    @root = root
  end

  attr_reader :root

  def self.build_tree(array)
    # require 'pry-moves'; binding.pry
    build_from_sorted = lambda do |arr|
      return nil if arr.nil? || arr.empty?

      middle_point = arr.length / 2
      first_half_length = (0...middle_point).size
      second_half_length = arr.length - first_half_length
      Node.new(arr[middle_point], build_from_sorted.call(arr[0, first_half_length]),
               build_from_sorted.call(arr[middle_point + 1, second_half_length]))
    end

    build_from_sorted.call(array.uniq.sort)
  end

  def insert_inner(value, node = root)
    # require 'pry-byebug'; binding.pry
    return Node.new(value) if node.nil?

    case value <=> node.data
    when 0
      node
    when -1
      Node.new(node.data, insert_inner(value, node.left), node.right)
    when 1
      Node.new(node.data, node.left, insert_inner(value, node.right))
    end
  end

  def insert(value)
    Tree.new(insert_inner(value))
  end

  def farthest_left(node)
    return node if node.left.nil?

    farthest_left(node.left)
  end

  def inorder_successor_value(node)
    farthest_left(node.right).data
  end

  def farthest_left_removed(node)
    return delete_node(node) if node.left.nil?

    Node.new(node.data, farthest_left_removed(node.left), node.right)
  end

  def delete_node_two_child(node)
    replace_value = inorder_successor_value(node)
    # require 'pry-byebug'; binding.pry
    Node.new(replace_value, node.left, farthest_left_removed(node.right))
  end

  def delete_node(node)
    if node.left.nil? && node.right.nil?
      nil
    elsif node.left.nil?
      node.right
    elsif node.right.nil?
      node.left
    else
      delete_node_two_child(node)
    end
  end

  def delete_inner(value, node = root)
    return nil if node.nil?

    case value <=> node.data
    when -1
      Node.new(node.data, delete_inner(value, node.left), node.right)
    when 1
      Node.new(node.data, node.left, delete_inner(value, node.right))
    when 0
      delete_node(node)
    end
  end

  def delete(value)
    Tree.new(delete_inner(value))
  end

  def find(value, node = root)
    return nil if node.nil?

    case value <=> node.data
    when -1
      find(value, node.left)
    when 1
      find(value, node.right)
    when 0
      node
    end
  end

  def level_order
    queue = [].push(root)
    result = []
    until queue.empty?
      popped = queue.shift
      result << popped.data
      queue.push(popped.left) unless popped.left.nil?
      queue.push(popped.right) unless popped.right.nil?
    end
    result
  end

  def level_order_rec(queue = [root], result = [])
    return result if queue.empty?

    front = queue[0]
    queue = queue[1..]
    queue.push(front.left) if front.left
    queue.push(front.right) if front.right
    level_order_rec(queue, result + [front.data])
  end

  def inorder(node = root)
    return [] if node.nil?

    [*inorder(node.left)] + [node.data] + [*inorder(node.right)]
  end

  def preorder(node = root)
    return [] if node.nil?

    [node.data] + [*preorder(node.left)] + [*preorder(node.right)]
  end

  def postorder(node = root)
    return [] if node.nil?

    [*postorder(node.left)] + [*postorder(node.right)] + [node.data]
  end

  def depth(node, result = 0, cursor = root)
    return nil if node.nil?

    case node.data <=> cursor.data
    when -1
      depth(node, result + 1, cursor.left)
    when 1
      depth(node, result + 1, cursor.right)
    when 0
      node == cursor ? result : nil
    end
  end

  def balanced?
    (height(root) - min_height(root)).abs <= 1
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def rebalance
    Tree.from_arr(inorder)
  end
end

def height(node, max = 0)
  return 0 if node.nil?
  return max if node.left.nil? && node.right.nil?

  left_height = height(node.left, max + 1)
  right_height = height(node.right, max + 1)
  left_height > right_height ? left_height : right_height
end

def min_height(node, min = 0)
  return 0 if node.nil?
  return min if node.left.nil? || node.right.nil?

  left_height = min_height(node.left, min + 1)
  right_height = min_height(node.right, min + 1)
  left_height < right_height ? left_height : right_height
end
