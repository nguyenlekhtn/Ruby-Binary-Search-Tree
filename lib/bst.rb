class Node
  include Comparable
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  attr_accessor :data, :left, :right

  def <=>(other)
    data <=> other.data
  end
end

class Tree
  def initialize(arr)
    @root = build_tree(arr)
  end

  attr_reader :root

  def build_tree(arr)
    return nil if arr.empty?

    middle_point = arr.length / 2
    node = Node.new(arr[middle_point])

    node.left = build_tree(arr[..middle_point - 1]) unless (middle_point - 1).negative?
    node.right = build_tree(arr[(middle_point + 1)..]) unless (middle_point + 1) >= arr.length

    node
  end

  def insert(value, node = root)

    comparison = value <=> node.value
    case comparison
    when -1
      insert(value, node.left)
    when 1
      insert(value, node.right)
    when 0
      return
    end
  end
end