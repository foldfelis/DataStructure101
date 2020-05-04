export DisjointSet
export find

mutable struct DisjointSet
    parent::Vector{Int64}

    DisjointSet(n::Int64) = new(-ones(Int64, n))
end

parent(set::DisjointSet, element::Int64) = set.parent[element]

function find(set::DisjointSet, element::Int64)
    p = parent(set, element)
    if p == -1 return element end
    find(set, p)
end

function Base.union!(set::DisjointSet, a::Int64, b::Int64)
    root1 = find(set, a)
    root2 = find(set, b)
    set.parent[root2] = root1
end
