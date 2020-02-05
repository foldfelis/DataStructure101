bt = BinaryTree{Int64}(1)
for i=2:25
    push!(bt, i)
end

println(bt)