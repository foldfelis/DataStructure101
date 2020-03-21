import Base

export AdjacencyList, Vertex
export relate!, nv, ne, degree

mutable struct Vertex{T}
    data::T
    related::Vector{Vertex{T}}

    Vertex{T}(data::T) where T = new(data, Vertex{T}[])
end

function Base.show(io::IO, v::Vertex)
    related = [i.data for i in v.related]
    length(related) > 0 ?
        print(io, "$(v.data)$(related)") : print(io, "$(v.data)[]")
end

mutable struct AdjacencyList{T}
    vertices::Vector{Vertex{T}}
    n_vertices::Int64

    AdjacencyList{T}() where T = new(Vertex{T}[], 0)
end

function Base.show(io::IO, g::AdjacencyList{T}) where T
    print(io, "AdjacencyList{$T}($([v for v in g.vertices]))")
end

Base.getindex(g::AdjacencyList, i::Int64) = g.vertices[i]

nv(g::AdjacencyList) = g.n_vertices

ne(g::AdjacencyList) = sum([length(v.related) for v in g.vertices])

neighbor(g::AdjacencyList, v::Vertex) = v.related

function Base.push!(g::AdjacencyList, v::Vertex)
    push!(g.vertices, v)
    g.n_vertices += 1
end

function relate!(g::AdjacencyList, v1::Vertex, v2::Vertex)
    push!(v1.related, v2)
end

function degree(g::AdjacencyList,  v::Vertex)
    related = v.related
    deg = length(related)

    # self-loop is counted twice
    for vertex in related
        if vertex == v deg += 1 end
    end

    return deg
end
