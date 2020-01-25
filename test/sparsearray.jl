T = SparseArray{Int64}
sa = T(10, 11)

for i = 1:10
    for j = 1:11
        index = (i, j)
        value = 10
        setindex!(sa, value, index)
    end
end
