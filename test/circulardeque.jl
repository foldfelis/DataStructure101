@info "Initial a Circular Deque with data '0'"
T = CircularDeque{Int64}
cl = T(19)
println("Show: $(cl)\n")
@info "Circular Deque type test: " @test cl isa T
println()

@info "Push test: Push data into CircularDeque 5 times by -5:-1"
for i = -5:-1
    pushfirst!(cl, i)
end
println("Show: $(cl)")
println("data: $(cl.data)")
println("head: $(cl.head)")
println("tail: $(cl.tail)\n")

@info "Length test"
println("There are $(cl.length) elements in the Deque.\n")

@info "Pop test"
for i = 1:10
    data = pop!(cl)
    println("Popped data: $(data)")
end
println("Show: $(cl)")
println("data: $(cl.data)")
println("head: $(cl.head)")
println("tail: $(cl.tail)\n")

@info "Push test: Push data into CircularDeque 20 times by 1:25"
for i = 1:25
    pushfirst!(cl, i)
end
println("Show: $(cl)")
println("data: $(cl.data)")
println("head: $(cl.head)")
println("tail: $(cl.tail)\n")

@info "Length test"
println("There are $(cl.length) elements in the list.\n")

@info "Pop test"
for i = 1:15
    data = pop!(cl)
    println("Popped data: $(data)")
end
println("Show: $(cl)")
println("data: $(cl.data)")
println("head: $(cl.head)")
println("tail: $(cl.tail)\n")
