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

println("\n* Push Test\n")

for i=1:20
    push!(ll, i)
end
println(ll)

movePtr(ll, -5)
println(ll)
push!(ll, 100)
println(ll)

println("\n* Delete Current Node Test\n")

movePtr(ll, 3)
println(ll)
current_data = delete!(ll)
println("Deleted data: $(current_data)")
println(ll)

println("\n* Move Test\n")

movePtr2head(ll)
println(ll)

movePtr2tail(ll)
println(ll)

println("\n* Pushfirst Test\n")
pushfirst!(ll, 123)
println(ll)

println("\n* Insert Test\n")

insert!(ll, 5987, 5)
println(ll)

insert!(ll, 8745, -5)
println(ll)

insert!(ll, "This is 0", 0)
println(ll)
insert!(ll, "This is 1", 1)
println(ll)
insert!(ll, "This is -1", -1)
println(ll)

println("\n* Delete Test\n")

delete!(ll, 0)
println(ll)
delete!(ll, 1)
println(ll)
delete!(ll, -1)
println(ll)
