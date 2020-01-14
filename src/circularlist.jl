mutable struct CircularList{T}
    data::Vector{T}
    length::Int64
    limit::Int64
    head::Int64

    CircularList{T}(n::Int64) where T = new(
        Vector{T}(undef, n), 0, n, 0)
end

length(cl::CircularList) = cl.length

function show(io::IO, cl::CircularList{T}) where T
    head = cl.head
    length = cl.length

    print(io, "CircularList{$(T), $(cl.limit)}([")

    for i = head:-1:head-length+1
        index = i%length
        if index < 1
            index += length
        end
        print(io, "$(cl.data[index]), ")
    end

    print(io, "])")
end

function move(cl::CircularList, n::Int64)
    limit = cl.limit

    cl.head += n
    cl.head %= limit
    if cl.head == 0
        cl.head = cl.limit
    end
end

function push!(cl::CircularList, data)
    move(cl, 1)
    cl.data[cl.head] = data
    cl.length += 1

    if cl.length > cl.limit
        cl.length = cl.limit
    end
end

function pop!(cl::CircularList, n::Int64)
    length = cl.length
    index = cl.head

    if n < 1 return nothing end

    index -= n-1
    if index < 1
        index += length
    end
    return cl.data[index]
end
