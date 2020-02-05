T = SparseArray{Int64}
sa = T(10, 11)

println(sa)

valueentry = ValueEntry{Int}(1, 1, 5)
push!(sa.data, valueentry)
println(sa)
