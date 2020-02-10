T = SparseArray{Int64}
sa = T(10, 11)
println(sa)

setindex!(sa, 5, 4, 20)
println(sa)
setindex!(sa, 5, 4, 21)
println(sa)

for i = 1:6
    for j = 2:8
        setindex!(sa, i, j, i*10+j)
    end
end
println(sa)

for i = 2:6
    for j = 2:8
        setindex!(sa, i, j, 0)
    end
end
println(sa)