abstract type Graph end

mutable struct AdjacencyMatrix <: Graph
    relation::BitArray
    n_vertices::Int64

    AdjacencyMatrix(n::Int64) = new(zeros(Bool, n, n), n)
end

function show(io::IO, g::Graph)
    println(io, "Graph(")
    for i = 1:g.n_vertices
        for j = 1:g.n_vertices print(io, "\t $(g.relation[i, j])") end
        println(io)
    end
    print(io, ")")
end

mutable struct WeightedAdjacencyMatrix{T <: Number} <: Graph
    relation::Array{T}
    n_vertices::Int64

    WeightedAdjacencyMatrix{T}(; n::Int64, random_g::Bool=true) where T =
        random_g ? new(abs.(rand(T, n, n)), n) : new(zeros(T, n, n), n)
end

nv(g::Graph) = g.n_vertices

ne(g::Graph) = sum(g.relation .!= 0)

function neighbor(g::Graph, v::Int64)
    neighbor_list = Int[]
    for (i, v) in enumerate(g.relation[v, 1:end])
        v == 0 && continue
        push!(neighbor_list, i)
    end

    return neighbor_list
end

relate!(g::AdjacencyMatrix, v1::Int64, v2::Int64) = (g.relation[v1, v2] = true)

relate!(g::WeightedAdjacencyMatrix{T}, v1::Int64, v2::Int64, w::T) where T =
    (g.relation[v1, v2] = w)

weight(g::WeightedAdjacencyMatrix) = g.relation

function probability(g::WeightedAdjacencyMatrix)
    g.relation ./ sum(g.relation, dims=2)
end

function randonwalk(g::WeightedAdjacencyMatrix{T}, x::Vector{T}, steps::Int64) where T
    p = probability(g)
    if steps > 0
        x = (x' * p^n)'
    end

    return x
end
