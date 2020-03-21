import Base

export make_set, find, union!

make_set(n::Int64) = -ones(Int64, n)

parent(set::Vector{Int64}, element::Int64) = set[element]

function find(set::Vector{Int64}, element::Int64)
    p = parent(set, element)
    if p == -1 return element end
    find(set, p)
end

function Base.union!(set::Vector{Int64}, a::Int64, b::Int64)
    root = find(set, a)
    set[b] = root
end
