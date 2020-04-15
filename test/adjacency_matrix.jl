using Test
using LinearAlgebra
using DataStructure101
const DS = DataStructure101

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

        w = zeros(Float64, n, n)
        w[2, 5] = 10.5
        @test weight(g) == w
    end

    @testset "Random Walk" begin
        n = 100
        city = WeightedAdjacencyMatrix{Float64}(n=n, random_g=true)
        p = probability(city)

        test_prob = []
        for i=1:n push!(test_prob, sum(p[i, 1:end]) ≈ 1.0) end
        @test all(test_prob)

        # Random Walk Begin
        x = collect(1.0:n)
        x = random_walk(city, x, 10000)
        @test p' * x ≈ x
    end

end

@testset "AdjacencyList" begin

    g = AdjacencyList(10)
    @test g isa AdjacencyList

    @test g[8] == 8
    @test g[11] == -1

    relate!(g, 10, 9)
    relate!(g, 10, 8)

    relate!(g, 9, 7)
    relate!(g, 9, 6)
    relate!(g, 8, 5)
    relate!(g, 8, 4)

    relate!(g, 7, 3)
    relate!(g, 7, 2)
    relate!(g, 6, 1)

    @test nv(g) == 10
    @test ne(g) == 9
    @test degree(g, 8) == 2
    @test degree(g, 6) == 1

    @test neighbor(g, 10) == [9, 8]

    @test repr(g) == "AdjacencyList(1(Int64[])2(Int64[])3(Int64[])4(Int64[])5(Int64[])" *
        "6([1])7([3, 2])8([5, 4])9([7, 6])10([9, 8]))"

end
