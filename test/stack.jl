@info "Initial a Stack with data '0'"
T = Stack{Int64}
stake = T(0)
println("Show: $(stake)\n")

@info "Type test: " @test stake isa T
println()

@info "Push test: Push data into stake 20 times by 1:20"
for i = 1:20
    push!(stake, i)
end
println("Show: $(stake)\n")

@info "Pop test: Pop data from stack 5 times"
for i = 1:5
    pop!(stake)
end
println("Show: $(stake)\n")
