require_relative 'lib/bst'

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
p arr
Tree.from_arr(arr).pretty_print

puts 'Insert 10'
Tree.from_arr(arr).insert(10).pretty_print

puts 'Delete 10'
Tree.from_arr(arr).insert(10).delete(10).pretty_print

puts 'Delete 23'
Tree.from_arr(arr).insert(10).delete(10).delete(23).pretty_print

puts 'Delete 4'
Tree.from_arr(arr).insert(10).delete(10).delete(23).delete(4).pretty_print

puts 'Delete 8'
Tree.from_arr(arr).insert(10).delete(10).delete(23).delete(4).delete(8).pretty_print

puts 'Find 9'
# require 'pry-byebug'; binding.pry
p Tree.from_arr(arr).find(9)

puts 'Find 10'
p Tree.from_arr(arr).find(10)

puts 'print level-order array'
Tree.from_arr(arr).pretty_print
p Tree.from_arr(arr).level_order
# require 'pry-byebug'; binding.pry
p Tree.from_arr(arr).level_order_rec

puts 'Print inorder'
p Tree.from_arr(arr).inorder

puts 'Print preorder'
p Tree.from_arr(arr).preorder

puts 'Print postorder'
p Tree.from_arr(arr).postorder

puts 'height'
p height(Tree.from_arr(arr).root)

puts 'depth of 23'
node23 = Tree.from_arr(arr).find(23)
p Tree.from_arr(arr).depth(node23)

puts 'depth of 9'
node9 = Tree.from_arr(arr).find(9)
p Tree.from_arr(arr).depth(node9)

puts 'height'
tree = Tree.from_arr(arr).insert(10)
tree.pretty_print
p height(tree.root)

puts 'balanced'
tree1 = Tree.from_arr(arr).insert(10)
tree1.pretty_print
p tree1.balanced?
tree2 = Tree.from_arr(arr)
tree2.pretty_print
p tree2.balanced?

puts 'rebalance'
tree1 = Tree.from_arr(arr).insert(10)
tree1.pretty_print
tree1.rebalance.pretty_print

puts 'rebalance'
tree2 = Tree.from_arr(arr).delete(5).insert(11).delete(1)
tree2.pretty_print
tree2.rebalance.pretty_print
