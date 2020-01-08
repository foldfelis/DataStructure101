using Test
include("../src/CircularList.jl")

node = Node("This is a node")
println(node)
type_result = @test typeof(node) == Node
println(type_result)
