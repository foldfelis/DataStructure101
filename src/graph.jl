export AbstractGraph, Graph
export DiAdjacencyMatrix, WeightedDiAdjacencyMatrix
export DiAdjacencyList, WeightedAdjacencyList
export nv, ne, relate!, unrelate!, neighbor, weight, degree
export probability, random_walk

abstract type AbstractGraph end

mutable struct DiAdjacencyMatrix <: AbstractGraph
    relation::BitArray
    n_vertices::Int64

    DiAdjacencyMatrix(n::Int64) = new(zeros(Bool, n, n), n)
end

mutable struct WeightedDiAdjacencyMatrix{T <: Number} <: AbstractGraph
    relation::Array{T}
    n_vertices::Int64

    function WeightedDiAdjacencyMatrix{T}(n::Int64; random::Bool=true) where {T <: Number}
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

weight(g::WeightedDiAdjacencyMatrix) = g.relation

function probability(g::WeightedDiAdjacencyMatrix)
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

relate!(g::DiAdjacencyMatrix, v1::Int64, v2::Int64) = (g.relation[v1, v2] = true)

function relate!(g::WeightedDiAdjacencyMatrix{T}, v1::Int64, v2::Int64, w::T) where T
    (g.relation[v1, v2] = w)
end

function random_walk(g::WeightedDiAdjacencyMatrix{T}, x::Vector{T}, steps::Int64) where T
    p = probability(g)
    if steps > 0
        x = p'^steps * x
    end

    return x
end

mutable struct DiAdjacencyList <: AbstractGraph
    relation::Vector{Vector{Int64}}
    n_vertices::Int64

    DiAdjacencyList(n::Int64) = new([Int[] for i=1:n], n)
end

mutable struct WeightedAdjacencyList{T} <: AbstractGraph
    relation::Vector{Vector{Int64}}
    weight::Vector{Vector{T}}
    n_vertices::Int64

    function WeightedAdjacencyList{T}(n::Int64) where {T <: Number}
        return new(
            [Int[] for i=1:n],
            [T[] for i=1:n],
            n
        )
    end
end

const AdjacencyListLike = Union{DiAdjacencyList, WeightedAdjacencyList}

Base.getindex(g::AdjacencyListLike, i::Int64) = 0 < i < g.n_vertices ? i : -1

nv(g::AdjacencyListLike) = g.n_vertices

neighbor(g::AdjacencyListLike, v::Int64) = g.relation[v]

ne(g::DiAdjacencyList) = sum([length(g.relation[v]) for v in 1:(g.n_vertices)])

degree(g::DiAdjacencyList, v::Int64) = length(g.relation[v])

function Base.show(io::IO, g::DiAdjacencyList)
    print(io, "DiAdjacencyList(")
    for i=1:g.n_vertices
        print(io, "$i[")
        for j=g.relation[i]
            print(io, "$j, ")
        end
        print(io, "], ")
    end
    print(io, ")")
end

relate!(g::DiAdjacencyList, v1::Int64, v2::Int64) = push!(g.relation[v1], v2)

function unrelate!(g::DiAdjacencyList, v1::Int64, v2::Int64)
    deleteat!(g.relation[v1], findall(x -> x == v2, g.relation[v1]))
end

ne(g::WeightedAdjacencyList) = sum([length(g.relation[v]) for v in 1:(g.n_vertices)])/2

degree(g::WeightedAdjacencyList, v::Int64) = sum(g.weight[v])

function Base.show(io::IO, g::WeightedAdjacencyList{T}) where T
    print(io, "WeightedAdjacencyList{$T}(")
    for i=1:g.n_vertices
        print(io, "$i[")
        for (index, j)=enumerate(g.relation[i])
            print(io, "$j($(g.weight[i][index])), ")
        end
        print(io, "], ")
    end
    print(io, ")")
end

function relate!(g::WeightedAdjacencyList{T}, v1::Int64, v2::Int64, w::T) where T
    push!(g.relation[v1], v2)
    push!(g.relation[v2], v1)
    push!(g.weight[v1], w)
    push!(g.weight[v2], w)
end

function unrelate!(g::WeightedAdjacencyList{T}, v1::Int64, v2::Int64) where T
    indexes = findall(x->x==v2, g.relation[v1])
    deleteat!(g.relation[v1], indexes)
    deleteat!(g.weight[v1], indexes)
    indexes = findall(x->x==v1, g.relation[v2])
    deleteat!(g.relation[v2], indexes)
    deleteat!(g.weight[v2], indexes)
end

function Graph(n::Int64, representation::Symbol; random::Bool=true, T=Float64)
    if representation == :di_matrix
        return DiAdjacencyMatrix(n)
    elseif representation == :di_list
        return DiAdjacencyList(n)
    elseif representation == :w_di_matrix
        return WeightedDiAdjacencyMatrix{T}(n, random=random)
    elseif representation == :w_list
        return WeightedAdjacencyList{T}(n)
    end
end
