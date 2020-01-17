mutable struct CircularQueue{T}
    data::Vector{T}
    length::Int64
    limit::Int64
    head::Int64
    tail::Int64

    CircularQueue{T}(n::Int64) where T =
        new(Vector{T}(undef, n), 0, n, 0, 0)
end

length(cl::CircularQueue) = cl.length

function nextindex(i::Int64, limit::Int64)
    #=
    to move next, i += 1 must apply,
    yet change i to 0-based i -= 1 must apply as well.
    Skiped those to reduce calculation.
    =#
    i %= limit
    i += 1 # change to 1-based index

    return i
end

function show(io::IO, cl::CircularQueue{T}) where T
    length = cl.length
    limit = cl.limit
    head = cl.head

    print(io, "CircularQueue{$(T), mem:$(length)/$(limit)}([")

    if length < 1
        print(io, "])")
        return
    end

    for i = head.-collect(1:length) # change to 0-based index
        if i < 0
            i += length
        end
        i %= limit
        i += 1 # change to 1-based index
        print(io, "$(cl.data[i]), ")
    end

    print(io, "])")
end

function pushfirst!(cl::CircularQueue, data)
    limit = cl.limit

    cl.head = nextindex(cl.head, limit)
    cl.data[cl.head] = data
    cl.length += 1
    if cl.length > limit
        cl.length = limit
    end

    # adjust tail
    length = cl.length
    index = cl.head

    index -= 1 # change to 0-based index
    index -= length-1
    index %= length
    if index < 0
        index += length
    end
    index += 1 # change to 1-based index

    cl.tail = index
end

function pop!(cl::CircularQueue)
    limit = cl.limit

    if cl.length < 1
        return
    end

    data = cl.data[cl.tail]
    cl.tail = nextindex(cl.tail, limit)
    cl.length -= 1

    return data
end
