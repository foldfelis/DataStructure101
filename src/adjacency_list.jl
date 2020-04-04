import Base

export AdjacencyList
export relate!, nv, ne, degree

# mutable struct Vertex{T}
#     data::T
#     related::Vector{Vertex{T}}
#
#     Vertex{T}(data::T) where T = new(data, Vertex{T}[])
# end

# function Base.show(io::IO, v::Vertex)
#     related = [i.data for i in v.related]
#     length(related) > 0 ?
#         print(io, "$(v.data)$(related)") : print(io, "$(v.data)[]")
# end

mutable struct AdjacencyList <: Graph
    relation::Vector{Vector{Int64}}
    n_vertices::Int64

    function AdjacencyList(n::Int64)
        new([Int[] for i=1:n], n)
    end
end

function Base.show(io::IO, g::AdjacencyList)
    print(io, "AdjacencyList(")
    for i=1:g.n_vertices
        print(io, "$i($(g.relation[i]))")
    end
    print(io, ")")
end

Base.getindex(g::AdjacencyList, i::Int64) = 0 < i < g.n_vertices ? i : -1

nv(g::AdjacencyList) = g.n_vertices

ne(g::AdjacencyList) = sum([length(g.relation[v]) for v in 1:(g.n_vertices)])

neighbor(g::AdjacencyList, v::Int64) = g.relation[v]

function relate!(g::AdjacencyList, v1::Int64, v2::Int64)
    push!(g.relation[v1], v2)
end

degree(g::AdjacencyList,  v::Int64) = length(g.relation[v])
