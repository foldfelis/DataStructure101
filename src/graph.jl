export AbstractGraph, Graph
export AdjacencyMatrix, WeightedAdjacencyMatrix
export AdjacencyList
export nv, ne, relate!, unrelate!, neighbor, weight, degree
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

mutable struct UndirectedWeightedAdjacencyList{T} <: AbstractGraph
    relation::Vector{Vector{Int64}}
    weight::Vector{Vector{T}}
    n_vertices::Int64

    function UndirectedWeightedAdjacencyList{T}(n::Int64) where T
        return new(
            [Int[] for i=1:n],
            [T[] for i=1:n],
            n
        )
    end
end

function Base.getindex(
    g::Union{AdjacencyList, UndirectedWeightedAdjacencyList},
    i::Int64
)
    return 0 < i < g.n_vertices ? i : -1
end

nv(g::Union{AdjacencyList, UndirectedWeightedAdjacencyList}) = g.n_vertices

function ne(g::Union{AdjacencyList, UndirectedWeightedAdjacencyList})
    return sum([length(g.relation[v]) for v in 1:(g.n_vertices)])
end

function neighbor(
    g::Union{AdjacencyList, UndirectedWeightedAdjacencyList},
    v::Int64
)
    return g.relation[v]
end

function degree(
    g::Union{AdjacencyList, UndirectedWeightedAdjacencyList},
    v::Int64
)
    return length(g.relation[v])
end

function Base.show(io::IO, g::AdjacencyList)
    print(io, "AdjacencyList(")
    for i=1:g.n_vertices
        print(io, "$i[")
        for j=g.relation[i]
            print(io, "$j, ")
        end
        print(io, "], ")
    end
    print(io, ")")
end

relate!(g::AdjacencyList, v1::Int64, v2::Int64) = push!(g.relation[v1], v2)

function unrelate!(g::AdjacencyList, v1::Int64, v2::Int64)
    deleteat!(g.relation[v1], findall(x->x==v2, g.relation[v1]))
end

function Base.show(io::IO, g::UndirectedWeightedAdjacencyList{T}) where T
    print(io, "UndirectedWeightedAdjacencyList{$T}(")
    for i=1:g.n_vertices
        print(io, "$i[")
        for (index, j)=enumerate(g.relation[i])
            print(io, "$j($(g.weight[i][index])), ")
        end
        print(io, "], ")
    end
    print(io, ")")
end

function relate!(
    g::UndirectedWeightedAdjacencyList{T},
    v1::Int64,
    v2::Int64,
    w::T
) where T
    push!(g.relation[v1], v2)
    push!(g.relation[v2], v1)
    push!(g.weight[v1], w)
    push!(g.weight[v2], w)
end

function unrelate!(
    g::UndirectedWeightedAdjacencyList{T},
    v1::Int64,
    v2::Int64,
) where T
    indexes = findall(x->x==v2, g.relation[v1])
    deleteat!(g.relation[v1], indexes)
    deleteat!(g.weight[v1], indexes)
    indexes = findall(x->x==v1, g.relation[v2])
    deleteat!(g.relation[v2], indexes)
    deleteat!(g.weight[v2], indexes)
end

function Graph(n::Int64, representation::Symbol; random::Bool=true, T=Float64)
    if representation == :matrix
        return AdjacencyMatrix(n)
    elseif representation == :list
        return AdjacencyList(n)
    elseif representation == :w_matrix
        return WeightedAdjacencyMatrix{T}(n=n, random=random)
    elseif representation == :udw_list
        return UndirectedWeightedAdjacencyList{T}(n)
    end
end
