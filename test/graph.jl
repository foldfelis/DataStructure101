using Test
using LinearAlgebra
using DataStructure101
const DS = DataStructure101

@testset "Graph" begin
    @testset "Adjacency Matrix" begin
        @testset "Basic operate" begin
            n = 10

            g = DS.Graph(n, :matrix)
            row_str = "\t false" ^ n
            data_str = "$row_str\n" ^ n
            @test repr(g) == "Graph(\n$data_str)"

            @test g isa DS.AbstractGraph
            @test g isa DS.AdjacencyMatrix
            @test DS.nv(g) == n
            @test DS.ne(g) == 0

            DS.relate!(g, 2, 5)
            @test DS.ne(g) == 1
            @test DS.neighbor(g, 2) == Int[5]

            g = DS.Graph(n, :w_matrix, random=false)

            row_str = "\t 0.0" ^ n
            data_str = "$row_str\n" ^ n
            @test repr(g) == "Graph(\n$data_str)"

            @test g isa DS.AbstractGraph
            @test g isa DS.WeightedAdjacencyMatrix
            @test DS.nv(g) == n
            @test DS.ne(g) == 0

            DS.relate!(g, 2, 5, 10.5)
            @test DS.ne(g) == 1
            @test DS.neighbor(g, 2) == Int[5]

            w = zeros(Float64, n, n)
            w[2, 5] = 10.5
            @test DS.weight(g) == w
        end

        @testset "Random Walk" begin
            n = 100
            city = DS.Graph(n, :w_matrix)
            p = DS.probability(city)

            test_prob = []
            for i=1:n push!(test_prob, sum(p[i, 1:end]) ≈ 1.0) end
            @test all(test_prob)

            # Random Walk Begin
            x = collect(1.0:n)
            x = DS.random_walk(city, x, 10000)
            @test p' * x ≈ x
        end

    end

    @testset "AdjacencyList" begin
        g = DS.Graph(10, :list)
        @test g isa DS.AbstractGraph
        @test g isa DS.AdjacencyList

        @test g[8] == 8
        @test g[11] == -1

        DS.relate!(g, 10, 9)
        DS.relate!(g, 10, 8)

        DS.relate!(g, 9, 7)
        DS.relate!(g, 9, 6)
        DS.relate!(g, 8, 5)
        DS.relate!(g, 8, 4)

        DS.relate!(g, 7, 3)
        DS.relate!(g, 7, 2)
        DS.relate!(g, 6, 1)

        @test DS.nv(g) == 10
        @test DS.ne(g) == 9
        @test DS.degree(g, 8) == 2
        @test DS.degree(g, 6) == 1

        @test DS.neighbor(g, 10) == [9, 8]

        @test repr(g) == "AdjacencyList(" *
            "1[], 2[], 3[], 4[], 5[], " *
            "6[1, ], 7[3, 2, ], 8[5, 4, ], 9[7, 6, ], 10[9, 8, ], )"

        DS.unrelate!(g, 6, 1)
        @test repr(g) == "AdjacencyList(" *
            "1[], 2[], 3[], 4[], 5[], " *
            "6[], 7[3, 2, ], 8[5, 4, ], 9[7, 6, ], 10[9, 8, ], )"
    end

    @testset "UndirectedWeightedAdjacencyList" begin
        g = DS.Graph(10, :udw_list)
        @test g isa DS.UndirectedWeightedAdjacencyList
        @test g isa DS.AbstractGraph

        @test g[8] == 8
        @test g[11] == -1

        DS.relate!(g, 10, 9, 9.0)
        DS.relate!(g, 10, 8, 8.0)

        DS.relate!(g, 9, 7, 7.0)
        DS.relate!(g, 9, 6, 6.0)
        DS.relate!(g, 8, 5, 5.0)
        DS.relate!(g, 8, 4, 4.0)

        DS.relate!(g, 7, 3, 3.0)
        DS.relate!(g, 7, 2, 2.0)
        DS.relate!(g, 6, 1, 1.0)

        @test DS.nv(g) == 10
        @test DS.ne(g) == 18
        @test DS.degree(g, 8) == 3
        @test DS.degree(g, 6) == 2

        @test DS.neighbor(g, 10) == [9, 8]

        @test repr(g) == "UndirectedWeightedAdjacencyList{Float64}(" *
            "1[6(1.0), ], 2[7(2.0), ], 3[7(3.0), ], 4[8(4.0), ], " *
            "5[8(5.0), ], 6[9(6.0), 1(1.0), ], " *
            "7[9(7.0), 3(3.0), 2(2.0), ], 8[10(8.0), 5(5.0), 4(4.0), ], " *
            "9[10(9.0), 7(7.0), 6(6.0), ], 10[9(9.0), 8(8.0), ], )"

        DS.unrelate!(g, 6, 1)
        @test repr(g) == "UndirectedWeightedAdjacencyList{Float64}(" *
            "1[], 2[7(2.0), ], 3[7(3.0), ], 4[8(4.0), ], " *
            "5[8(5.0), ], 6[9(6.0), ], " *
            "7[9(7.0), 3(3.0), 2(2.0), ], 8[10(8.0), 5(5.0), 4(4.0), ], " *
            "9[10(9.0), 7(7.0), 6(6.0), ], 10[9(9.0), 8(8.0), ], )"
    end
end
