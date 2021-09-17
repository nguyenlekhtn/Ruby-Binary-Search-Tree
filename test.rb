require_relative 'lib/bst'
require "awesome_print"

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
p arr
Tree.from_arr(arr).pretty_print

puts "Insert 10"
Tree.from_arr(arr).insert(10).pretty_print

puts "Delete 10"
Tree.from_arr(arr).insert(10).delete(10).pretty_print

puts "Delete 23"
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

puts "print level-order array"
Tree.from_arr(arr).pretty_print
p Tree.from_arr(arr).level_order
# require 'pry-byebug'; binding.pry
p Tree.from_arr(arr).level_order_rec

puts "Print inorder"
p Tree.from_arr(arr).inorder

puts "Print preorder"
p Tree.from_arr(arr).preorder

puts "Print postorder"
p Tree.from_arr(arr).postorder
