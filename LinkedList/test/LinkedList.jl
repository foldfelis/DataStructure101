using Test
include("../src/LinkedList.jl")

#############
# Node Test #
#############

node = Node(0)
println(node)

type_result = @test typeof(node) == Node
println("Type test result: $(type_result)\n")

####################
# Linked List Test #
####################

ll = LinkedList(0)
println(ll)
type_result = @test typeof(ll) == LinkedList
println("Type test result: $(type_result)\n")

for i=1:20
    push!(ll, i)
end
println(ll)

movePtr(ll, -5)
println(ll)
push!(ll, 100)
println(ll)
