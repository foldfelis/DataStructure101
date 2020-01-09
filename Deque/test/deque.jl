using Test
include("../src/deque.jl")

deque = Deque("Deque")
println(deque)
type_result = @test typeof(deque) == Deque
println(type_result)

for i = 1:20
    push!(deque, i)
end
println(deque)

for i = 31:35
    pushfirst!(deque, i)
end
println(deque)

removed_data = pop!(deque)
println("Removed from tail: $(removed_data)")
println(deque)

removed_data = popfirst!(deque)
println("Removed from head: $(removed_data)")
println(deque)
