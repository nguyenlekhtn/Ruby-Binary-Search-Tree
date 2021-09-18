require_relative 'lib/bst'

puts 'Create a binary search tree from an array of random numbers'
tree = Tree.from_arr(Array.new(15) { rand(1..100) })
tree.pretty_print
puts "Balanced? #{tree.balanced?}"
puts "\nLevel-order"
p tree.level_order
puts "\nPreorder"
p tree.preorder
puts "\nInorder"
p tree.inorder
puts "\nPostorder"
p tree.postorder
puts "\nAdd 120, 125, 140"
tree = tree.insert(120).insert(125).insert(140)
tree.pretty_print
puts "Balanced: #{tree.balanced?}"
puts "\nRebalance"
tree = tree.rebalance
tree.pretty_print
puts "Balanced: #{tree.balanced?}"
