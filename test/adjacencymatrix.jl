@testset "Adjacency Matrix" begin

    g = AdjacencyMatrix(10)
    @test g isa Graph
    @test g isa AdjacencyMatrix
    @test nv(g) == 10
    @test ne(g) == 0

    relate!(g, 2, 5)
    @test ne(g) == 1
    @test neighbor(g, 2) == Int[5]

    g = WeightedAdjacencyMatrix{Float64}(10)
    @test g isa Graph
    @test g isa WeightedAdjacencyMatrix
    @test nv(g) == 10
    @test ne(g) == 0

    relate!(g, 2, 5, 10.5)
    @test ne(g) == 1
    @test neighbor(g, 2) == Int[5]

end
