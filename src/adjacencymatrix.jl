#=
- [x] `nv(g)`: number of vertices in graph
- [x] `ne(g)`: number of edges in graph
- [x] `neighbor(g, v)`: vertices that are the neighbors of vertex `v` in graph `g`
- [x] `Base.show(g)`: show graph `g`
- [x] `weight(g)`: weighted matrix of a graph `g`
- [ ] `probability(g)`: probability matrix of a graph `g`
- [ ] `randonwalk(g, x, n)`: perform random walk on graph `g` starting from state `x` with `n` steps
=#

abstract type Graph end

mutable struct AdjacencyMatrix <: Graph
    relation::BitArray
    n_vertices::Int64

    AdjacencyMatrix(n::Int64) = new(zeros(Bool, n, n), n)
end

function show(io::IO, g::Graph)
    println(io, "Graph(")
    for j = 1:g.n_vertices
        for i = 1:g.n_vertices print(io, "\t $(g.relation[i, j])") end
        println(io)
    end
    print(io, ")")
end

mutable struct WeightedAdjacencyMatrix{T <: Number} <: Graph
    relation::Array{T}
    n_vertices::Int64

    WeightedAdjacencyMatrix{T}(n::Int64) where T = new(zeros(T, n, n), n)
end

nv(g::Graph) = g.n_vertices

ne(g::Graph) = sum(g.relation .!= 0)

relate(g::AdjacencyMatrix, v1::Int64, v2::Int64) = (g.relation[v1, v2] = true)

relate(g::WeightedAdjacencyMatrix{T}, v1::Int64, v2::Int64, w::T) where T =
    (g.relation[v1, v2] = w)

neighbor(g::Graph, v::Int64) = sum(g.relation[v, 1:end] .!= 0)
