@info "Initial a Binary Tree with data '1'"
bt = BinaryTree{Int64}(1)
println(bt, "\n")

@info "Push Test: Push 2:25 value into tree"
for i=2:25
    push!(bt, i)
end
println(bt, "\n")

@info "Get Test: Get 10th node from tree"
node = getindex(bt, 10)
println(node, "\n")

@info "Value Test: Get 10th value from tree"
val = value(bt, 10)
println(@test val == 10)
println("10th value in tree: $val \n")

@info "Value Test: Get Left child of 10th value from tree"
val = leftchild(bt, 10)
println(@test val == 20)
println("Left child of 10th value in tree: $val \n")

@info "Value Test: Get Right child of 10th value from tree"
val = rightchild(bt, 10)
println(@test val == 21)
println("Right child of 10th value in tree: $val \n")

@info "Get Root"
node = bt.root
println("Root: $(node.value) \n")