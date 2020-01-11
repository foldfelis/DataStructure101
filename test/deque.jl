@info "Initial a Deque with data '0'"
T = Deque{Int64}
deque = T(0)
println("Show: $(deque)\n")

@info "Type test: " @test deque isa T
println()

@info "Push test: Push data into deque 20 times by 1:20"
for i = 1:20
    push!(deque, i)
end
println("Show: $(deque)\n")

@info "Pushfirst test: Push data into deque 20 times by 31:35"
for i = 31:35
    pushfirst!(deque, i)
end
println("Show: $(deque)\n")

@info "Pop test: Pop data from tail of deque"
removed_data = pop!(deque)
println("Removed from tail: $(removed_data)")
println("Show: $(deque)\n")

@info "Pop test: Pop data from head of deque"
removed_data = popfirst!(deque)
println("Removed from head: $(removed_data)")
println("Show: $(deque)\n")
