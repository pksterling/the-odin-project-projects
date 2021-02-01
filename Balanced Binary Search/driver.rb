require_relative 'bst'

puts "Booting BST driver...\n\n"

puts "Creating binary search tree..."
tree = Tree.new(Array.new(15) { rand(1..100) })
puts "Binary search tree complete.\n\n"

puts "Balanced status: #{tree.balanced?}."
unless tree.balanced?
  puts "Rebalancing tree..."
  tree.rebalance
  puts "Balanced status: #{tree.balanced?}."
end
puts ""

puts "Level order traversal: #{tree.level_order}"
puts "Preorder traversal: #{tree.preorder}"
puts "Postorder traversal: #{tree.postorder}"
puts "Inorder traversal: #{tree.inorder}\n\n"

extra_numbers = Array.new(150) { rand(1..1000) }
puts "Adding #{extra_numbers.length} extra numbers...\n\n"
extra_numbers.each{ |number| tree.insert(number)}

puts "Balanced status: #{tree.balanced?}."
unless tree.balanced?
  puts "Rebalancing tree..."
  tree.rebalance
  puts "Balanced status: #{tree.balanced?}."
end
puts ""

puts "Level order traversal: #{tree.level_order}"
puts "Preorder traversal: #{tree.preorder}"
puts "Postorder traversal: #{tree.postorder}"
puts "Inorder traversal: #{tree.inorder}\n\n"

puts tree.pretty_print