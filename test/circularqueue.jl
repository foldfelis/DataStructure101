@info "Initial a Circular Queue with data '0'"
T = CircularQueue{Int64}
cl = T(19)
println("Show: $(cl)\n")
@info "Circular Queue type test: " @test cl isa T
println()

@info "Push test: Push data into CircularQueue 5 times by -5:-1"
for i = -5:-1
    pushfirst!(cl, i)
end
println("Show: $(cl)")
println("data: $(cl.data)")
println("head: $(cl.head)")
println("tail: $(cl.tail)\n")

@info "Length test"
println("There are $(cl.length) elements in the Queue.\n")

@info "Pop test"
for i = 1:10
    data = pop!(cl)
    println("Popped data: $(data)")
end
println("Show: $(cl)")
println("data: $(cl.data)")
println("head: $(cl.head)")
println("tail: $(cl.tail)\n")

@info "Push test: Push data into CircularQueue 20 times by 1:25"
for i = 1:25
    pushfirst!(cl, i)
end
println("Show: $(cl)")
println("data: $(cl.data)")
println("head: $(cl.head)")
println("tail: $(cl.tail)\n")

@info "Length test"
println("There are $(cl.length) elements in the Queue.\n")

@info "Pop test"
for i = 1:15
    data = pop!(cl)
    println("Popped data: $(data)")
end
println("Show: $(cl)")
println("data: $(cl.data)")
println("head: $(cl.head)")
println("tail: $(cl.tail)\n")
