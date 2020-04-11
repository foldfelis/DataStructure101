export CircularQueue

mutable struct CircularQueue{T}
    data::Vector{T}
    length::Int64
    size::Int64
    head::Int64

    CircularQueue{T}(n::Int64) where T =
        new(Vector{T}(undef, n), 0, n, 0)
end

Base.length(cl::CircularQueue) = cl.length

Base.size(cl::CircularQueue) = cl.size

function Base.show(io::IO, cl::CircularQueue{T}) where T
    length = cl.length
    size = cl.size
    head = cl.head

    print(io, "CircularQueue{$(T), mem:$(length)/$(size)}([")

    if length < 1
        print(io, "])")
        return
    end

    for i = head.-collect(1:length) # change to 0-based index
        i = (i + size) % size # circular
        i += 1 # change to 1-based index
        print(io, "$(cl.data[i]), ")
    end

    print(io, "])")
end

function Base.pushfirst!(cl::CircularQueue, data)
    size = cl.size

    #=
        cl.head += 1 # move to next index
        cl.head -= 1 # change to 0-based index
        Skiped those to reduce calculation.
    =#
    cl.head %= size # circular
    cl.head += 1 # change to 1-based index

    cl.data[cl.head] = data
    cl.length += 1
    if cl.length > size
        cl.length = size
    end
end

function Base.pop!(cl::CircularQueue)
    size = cl.size
    length = cl.length

    if length < 1 return end

    index = cl.head
    index -= 1 # change to 0-based index
    index -= (length - 1) # move from head to tail
    index = (index + size) % size # circular
    index += 1 # change to 1-based index

    cl.length -= 1

    return cl.data[index]
end
