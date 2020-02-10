T = SparseArray{Int64}
sa = T(10, 11)
println(sa)

setindex!(sa, 5, 4, 20)
println(sa)
setindex!(sa, 5, 4, 21)
println(sa)
