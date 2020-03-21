@testset "AdjacencyList" begin

    T_el = Int64
    g = AdjacencyList{T_el}()
    @test g isa AdjacencyList

    for i=1:10
        v = Vertex{T_el}(i)
        push!(g, v)
    end

    relate!(g, g[10], g[9])
    relate!(g, g[10], g[8])

    relate!(g, g[9], g[7])
    relate!(g, g[9], g[6])
    relate!(g, g[8], g[5])
    relate!(g, g[8], g[4])

    relate!(g, g[7], g[3])
    relate!(g, g[7], g[2])
    relate!(g, g[6], g[1])

    @test nv(g) == 10
    @test ne(g) == 9
    @test degree(g, g[8]) == 2
    @test degree(g, g[6]) == 1

    @test neighbor(g, g[10]) == [g[9], g[8]]

    @test repr(g) == "AdjacencyList{Int64}(Vertex{Int64}[1[], 2[], 3[], 4[], 5[], 6[1], 7[3, 2], 8[5, 4], 9[7, 6], 10[9, 8]])"

end
