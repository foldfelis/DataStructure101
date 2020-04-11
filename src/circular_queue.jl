export CircularQueue

mutable struct CircularQueue{T}
    data::Vector{T}
    length::Int64
    max_size::Int64
    head::Int64

    CircularQueue{T}(n::Int64) where T = new(Vector{T}(undef, n), 0, n, 0)
end

Base.length(cl::CircularQueue) = cl.length

Base.size(cl::CircularQueue) = (cl.max_size)

function Base.show(io::IO, cl::CircularQueue{T}) where T
    length = cl.length
    max_size = cl.max_size
    head = cl.head

    print(io, "CircularQueue{$(T), mem:$(length)/$(max_size)}([")

    if length < 1
        print(io, "])")
        return
    end

    for i = head.-collect(1:length) # change to 0-based index
        i = (i + max_size) % max_size # circular
        i += 1 # change to 1-based index
        print(io, "$(cl.data[i]), ")
    end

    print(io, "])")
end

function Base.pushfirst!(cl::CircularQueue, data)
    max_size = cl.max_size

    #=
        cl.head += 1 # move to next index
        cl.head -= 1 # change to 0-based index
        Skiped those to reduce calculation.
    =#
    cl.head %= max_size # circular
    cl.head += 1 # change to 1-based index

    cl.data[cl.head] = data
    cl.length += 1
    if cl.length > max_size
        cl.length = max_size
    end
end

function Base.pop!(cl::CircularQueue)
    max_size = cl.max_size
    length = cl.length

    if length < 1 return end

    index = cl.head
    index -= 1 # change to 0-based index
    index -= (length - 1) # move from head to tail
    index = (index + max_size) % max_size # circular
    index += 1 # change to 1-based index

    cl.length -= 1

    return cl.data[index]
end
