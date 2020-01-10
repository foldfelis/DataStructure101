using Test
include("../src/CircularList.jl")

#############
# Node Test #
#############

node = Node("This is a node")
println(node)
type_result = @test typeof(node) == Node
println(type_result)

#######################
# Circular List  Test #
#######################

cl = CircularList(0)
println(cl)
type_result = @test typeof(cl) == CircularList
println(type_result)

for i = 1:20
    push!(cl, i)
end
println(cl)

current_data = delete!(cl)
println("Deleted data: $(current_data)")
println(cl)


movePtr(cl, 101)
println(cl)

movePtr(cl, -101)
println(cl)

push!(cl, "This is 101", 101)
println(cl)

push!(cl, "This is -101", -43)
println(cl)

current_data = delete!(cl, 48)
println("Deleted data: $(current_data)")
println(cl)

current_data = delete!(cl, -21)
println("Deleted data: $(current_data)")
println(cl)
