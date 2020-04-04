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
