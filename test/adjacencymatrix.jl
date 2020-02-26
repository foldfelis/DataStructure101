@testset "Adjacency Matrix" begin

    g = AdjacencyMatrix(10)
    @test g isa Graph
    @test g isa AdjacencyMatrix
    @test nv(g) == 10
    @test ne(g) == 0
    @show g
end
