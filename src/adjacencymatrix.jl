#=
- [x] `nv(g)`: number of vertices in graph
- [x] `ne(g)`: number of edges in graph
- [ ] `neighbor(g, v)`: vertices that are the neighbors of vertex `v` in graph `g`
- [x] `Base.show(g)`: show graph `g`
- [ ] `weight(g)`: weighted matrix of a graph `g`
- [ ] `probability(g)`: probability matrix of a graph `g`
- [ ] `randonwalk(g, x, n)`: perform random walk on graph `g` starting from state `x` with `n` steps
=#

abstract type Graph end

mutable struct AdjacencyMatrix <: Graph
    relation::BitArray
    n_vertices::Int64

    AdjacencyMatrix(n::Int64) = new(BitArray(zeros(Int, n, n)), n)
end

function show(io::IO, g::AdjacencyMatrix)
    println(io, "AdjacencyMatrix(")
    for j = 1:g.n_vertices
        for i = 1:g.n_vertices
            print(io, "\t$(g.relation[i, j])")
        end
        println(io)
    end
    print(io, ")")
end

nv(g::Graph) = g.n_vertices

ne(g::Graph) = length(g.relation[g.relation .== true])
