using LinearAlgebra

@testset "Adjacency Matrix" begin

    @testset "Basic operate" begin
        n = 10

        g = AdjacencyMatrix(n)
        row_str = "\t false" ^ n
        data_str = "$row_str\n" ^ n
        @test repr(g) == "Graph(\n$data_str)"

        @test g isa Graph
        @test g isa AdjacencyMatrix
        @test nv(g) == n
        @test ne(g) == 0

        relate!(g, 2, 5)
        @test ne(g) == 1
        @test neighbor(g, 2) == Int[5]

        g = WeightedAdjacencyMatrix{Float64}(n=n, random_g=false)

        row_str = "\t 0.0" ^ n
        data_str = "$row_str\n" ^ n
        @test repr(g) == "Graph(\n$data_str)"

        @test g isa Graph
        @test g isa WeightedAdjacencyMatrix
        @test nv(g) == n
        @test ne(g) == 0

        relate!(g, 2, 5, 10.5)
        @test ne(g) == 1
        @test neighbor(g, 2) == Int[5]
    end

    @testset "Random Walk" begin
        n = 3
        city = WeightedAdjacencyMatrix{Float64}(n=n, random_g=true)
        p = probability(city)

        test_prob = []
        for i=1:n push!(test_prob, sum(p[i, 1:end]) ≈ 1.0) end
        @test all(test_prob)

        # Random Walk Begin
        x = collect(1.0:n)
        randonwalk(city, x, 1000)
    end

end
