export AbstractGraph, AdjacencyMatrix, WeightedAdjacencyMatrix, AdjacencyList, Graph
export nv, ne, relate!, neighbor, weight, degree
export probability, random_walk

abstract type AbstractGraph end

mutable struct AdjacencyMatrix <: AbstractGraph
    relation::BitArray
    n_vertices::Int64

    AdjacencyMatrix(n::Int64) = new(zeros(Bool, n, n), n)
end

mutable struct WeightedAdjacencyMatrix{T <: Number} <: AbstractGraph
    relation::Array{T}
    n_vertices::Int64

    function WeightedAdjacencyMatrix{T}(; n::Int64, random::Bool=true) where T
        return random ? new(abs.(rand(T, n, n)), n) : new(zeros(T, n, n), n)
    end
end

nv(g::AbstractGraph) = g.n_vertices

ne(g::AbstractGraph) = sum(g.relation .!= 0)

function neighbor(g::AbstractGraph, v::Int64)
    neighbor_list = Int[]
    for (i, v) in enumerate(g.relation[v, 1:end])
        v == 0 && continue
        push!(neighbor_list, i)
    end

    return neighbor_list
end

weight(g::WeightedAdjacencyMatrix) = g.relation

function probability(g::WeightedAdjacencyMatrix)
    g.relation ./ sum(g.relation, dims=2)
end

function Base.show(io::IO, g::AbstractGraph)
    println(io, "Graph(")
    for i = 1:g.n_vertices
        for j = 1:g.n_vertices print(io, "\t $(g.relation[i, j])") end
        println(io)
    end
    print(io, ")")
end

relate!(g::AdjacencyMatrix, v1::Int64, v2::Int64) = (g.relation[v1, v2] = true)

function relate!(g::WeightedAdjacencyMatrix{T}, v1::Int64, v2::Int64, w::T) where T
    (g.relation[v1, v2] = w)
end

function random_walk(g::WeightedAdjacencyMatrix{T}, x::Vector{T}, steps::Int64) where T
    p = probability(g)
    if steps > 0
        x = p'^steps * x
    end

    return x
end

mutable struct AdjacencyList <: AbstractGraph
    relation::Vector{Vector{Int64}}
    n_vertices::Int64

    AdjacencyList(n::Int64) = new([Int[] for i=1:n], n)
end

# TODO: WeightedAdjacencyList

Base.getindex(g::AdjacencyList, i::Int64) = 0 < i < g.n_vertices ? i : -1

nv(g::AdjacencyList) = g.n_vertices

ne(g::AdjacencyList) = sum([length(g.relation[v]) for v in 1:(g.n_vertices)])

neighbor(g::AdjacencyList, v::Int64) = g.relation[v]

degree(g::AdjacencyList,  v::Int64) = length(g.relation[v])

function Base.show(io::IO, g::AdjacencyList)
    print(io, "AdjacencyList(")
    for i=1:g.n_vertices
        print(io, "$i($(g.relation[i]))")
    end
    print(io, ")")
end

function relate!(g::AdjacencyList, v1::Int64, v2::Int64)
    push!(g.relation[v1], v2)
end

function Graph(n::Int64, representation::Symbol; random::Bool=true, T=Float64)
    (representation == :matrix) &&
        (return AdjacencyMatrix(n))
    (representation == :list) &&
        (return AdjacencyList(n))
    (representation == :w_matrix) &&
        (return WeightedAdjacencyMatrix{T}(n=n, random=random))
end
