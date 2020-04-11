export Deque

mutable struct Deque{T}
    data::Vector{T}
    Deque{T}(d::T) where T = new(T[d])
end

function Base.show(io::IO, deque::Deque)
    print(io, "Deque($(deque.data))")
end

function Base.push!(deque::Deque, d)
    push!(deque.data, d)
end

function Base.pushfirst!(deque::Deque, d)
    pushfirst!(deque.data, d)
end

function Base.pop!(deque::Deque)
    data = pop!(deque.data)
    return data
end

function Base.popfirst!(deque::Deque)
    data = popfirst!(deque.data)
    return data
end
