# Ruby Binary Search Tree

This project is to create a Binary Search Tree class and its method with Ruby language. 

All class and its methods are inside `lib/bst.rb` file. `test.rb` is used to test when I was coding the project. `main.rb` is to demonstrate if the #rebalance works  

I tried to apply some functional programming concepts I read from http://www.harukizaemon.com/blog/2010/03/01/functional-programming-in-object-oriented-languages/. One of that is to not mutate the object's state but return a new instance object of class Tree with state changed. You can see that in my #insert, #remove and some other methods.




## Methods

| Method name                         | Description                                                                                |
|-------------------------------------|--------------------------------------------------------------------------------------------|
| #insert and #delete                 | accepts a value to insert/delete                                                           |
| #find                               | accepts a value and returns the node with the given value                                  |
| ##level_order                       | Return an array of values. This method will traverse the tree in breadth-first level order |
| #inorder, #preorder, and #postorder | Each method should traverse the tree in their respective depth-first order.                |
| #height                             | accepts a node and returns its height                                                      |
| #depth                              | accepts a node and returns its depth                                                       |
| #balanced?                          | checks if the tree is balanced                                                             |
| #rebalance                          | rebalances an unbalanced tree                                                              |
