@info "Initial a Circular List with data '0'"
T = CircularList{Int64}
cl = T(19)
println("Show: $(cl)\n")
@info "Circular List type test: " @test cl isa T
println()

@info "Push test: Push data into CircularList 5 times by -5:-1"
for i = -5:-1
    push!(cl, i)
end
println("Show: $(cl)\n")

@info "Push test: Push data into CircularList 20 times by 1:20"
for i = 1:20
    push!(cl, i)
end
println("Show: $(cl)\n")

@info "Push test: Push data into CircularList 10 times by 31:40"
for i = 31:40
    push!(cl, i)
end
println("Show: $(cl)\n")
