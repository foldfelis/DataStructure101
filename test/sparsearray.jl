@info "Initial a SparseArray with size(10, 11)"
T = SparseArray{Int64}
sa = T(10, 11)
println("Show: $(sa)\n")
@test sa isa T
println()

@info "SetIndex test: SetIndex data into SparseArray"
setindex!(sa, 5, 4, 20)
len = length(sa)
println(@test len == 1)
println("Length of array: $(len)")
println("Show: $(sa)\n")

@info "SetIndex test: SetIndex data into SparseArray at same place"
setindex!(sa, 5, 4, 21)
println(@test len == 1)
println("Length of array: $(len)")
println("Show: $(sa)\n")

@info "SetIndex test: SetIndex many data into SparseArray"
for i = 1:6
    for j = 2:8
        setindex!(sa, i, j, i*10+j)
    end
end
println("Length of array: $(length(sa))")
println("Show: $(sa)\n")

@info "SetIndex test: SetIndex many 0 into SparseArray"
for i = 2:6
    for j = 2:8
        setindex!(sa, i, j, 0)
    end
end
println("Length of array: $(length(sa))")
println("Show: $(sa)\n")

@info "GetIndex test: (1, 5)"
println("Value at ndex(1, 5): $(getindex(sa, 1, 5))\n")

@info "eltype test"
println(eltype(sa))