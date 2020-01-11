@info "Initial a Circular List with data '0'"
T = CircularList{Int64}
cl = T(0)
println("Show: $(cl)\n")
@info "Circular List type test: " @test cl isa T
println()

@info "Push test: Push data into CircularList 20 times by 1:20"
for i = 1:20
    push!(cl, i)
end
println("Show: $(cl)\n")

@info "Delete Current Node Test"
current_data = delete!(cl)
println("Deleted data: $(current_data)")
println("Show: $(cl)\n")

@info "Move Test: Move 101 node"
movePtr(cl, 101)
println("Show: $(cl)\n")

@info "Move Test: Move -101 node"
movePtr(cl, -101)
println("Show: $(cl)\n")

@info "Push Test: Push '101101' after next 101th node"
push!(cl, 101101, 101)
println("Show: $(cl)\n")

@info "Push Test: Push '-4343' after next -43th node"
push!(cl, -4343, -43)
println("Show: $(cl)\n")

@info "Delete test: Delete the 48th node after current node"
current_data = delete!(cl, 48)
println("Deleted data: $(current_data)")
println("Show: $(cl)\n")

@info "Delete test: Delete the -21th node after current node"
current_data = delete!(cl, -21)
println("Deleted data: $(current_data)")
println("Show: $(cl)\n")
