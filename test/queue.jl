@info "Initial a Queue with data '0'"
T = Queue{Int64}
queue = T(0)
println("Show: $(queue)\n")

@info "Type test: " @test queue isa T
println()

@info "Push test: Push data into queue 20 times by 1:20"
for i = 1:20
    push!(queue, i)
end
println("Show: $(queue)\n")

@info "Pop test: Pop data from queue 5 times"
for i = 1:5
    pop!(queue)
end
println("Show: $(queue)\n")
