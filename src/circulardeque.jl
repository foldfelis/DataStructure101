mutable struct CircularDeque{T}
    data::Vector{T}
    length::Int64
    limit::Int64
    head::Int64
    tail::Int64

    CircularDeque{T}(n::Int64) where T = new(
        Vector{T}(undef, n), 0, n, 0, 0)
end

length(cl::CircularDeque) = cl.length

function show(io::IO, cl::CircularDeque{T}) where T
    length = cl.length
    limit = cl.limit
    head = cl.head

    print(io, "CircularDeque{$(T), mem:$(length)/$(limit)}([")

    if length < 1
        print(io, "])")
        return
    end

    for i = head.-collect(1:length) # Change to 0-based index
        if i < 0
            i += length
        end
        i %= limit
        i += 1 # Change to 1-based index
        print(io, "$(cl.data[i]), ")
    end

    print(io, "])")
end

function pushfirst!(cl::CircularDeque, data)
    limit = cl.limit

    #=
    To move next, head += 1 must apply,
    yet change head to 0-based head -= 1 must apply as well,
    therefore skiped.
    =#
    cl.head %= limit
    cl.head += 1 # Change to 1-based index

    cl.data[cl.head] = data

    cl.length += 1
    if cl.length > limit
        cl.length = limit
    end

    adjtail(cl)
end

function adjtail(cl::CircularDeque)
    length = cl.length
    index = cl.head

    index -= 1 # Change to 0-based index
    index -= length-1
    index %= length
    if index < 0
        index += length
    end
    index += 1 # Change to 1-based index

    cl.tail = index
end

function pop!(cl::CircularDeque)
    limit = cl.limit
    data = nothing

    if cl.length > 0
        data = cl.data[cl.tail]

        #=
        To move next, tail += 1 must apply,
        yet change head to 0-based head -= 1 must apply as well,
        therefore skiped.
        =#
        cl.tail %= limit
        cl.tail += 1 # Change to 1-based index

        cl.length -= 1
    end

    return data
end
