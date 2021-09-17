require 'pp'


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
      Node.new(arr[middle_point], build_from_sorted.call(arr[0, first_half_length]), build_from_sorted.call(arr[middle_point + 1, second_half_length]))
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
    return if queue.empty?

    puts queue[0]
    
  end

  # def remove_from_tree(parent_node, branch)
  #   parent_node.set_branch(branch, nil)
  # end

  # def delete_node_one_child(parent_node, branch)
  #   node = parent_node.get_branch(branch)
  #   node_child = node.left || node.right
  #   parent_node.set_branch(branch, node_child)
  # end

  # def tree_min(node)
  #   return node if node.left.nil?

  #   tree_min(node.left)
  # end

  # def find_min_right_subtree(node)
  #   tree_min(node.right)
  # end

  # def delete_node_two_child(node)
  #   found_parent, found_branch = find_min_right_subtree(node)
  #   found_node = found_parent.get_branch(branch)

  #   node.data = found_node.data
  #   delete_node(found_parent, found_branch)
  # end

  # def delete_node(parent_node, branch)
  #   node = parent_node.get_branch(branch)
  #   case node.child_size
  #   when 0
  #     remove_from_tree(parent_node, branch)
  #   when 1
  #     delete_node_one_child(parent_node, branch)
  #   when 2
  #     delete_node_two_child(parent_node, branch)
  #   end
  # end

  # def delete(value)
  #   node = find(value)
  #   delete_node(node)
  # end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end