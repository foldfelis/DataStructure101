mutable struct CircularList{T}
    data::Vector{Union{T, Missing}}
    length::Int64
    head::Int64

    CircularList{T}(n::Int64) where T = new(
        Vector{Union{T, Missing}}(missing, n), n, 0)
end

function show(io::IO, cl::CircularList{T}) where T
    head = cl.head
    length = cl.length

    print(io, "CircularList{$(T)}([..., ")

    for i = head:head+length-1
        index = i%length
        if index == 0
            index = length
        end
        print(io, "$(cl.data[index]), ")
    end

    print(io, " ...])")
end

function movePtr(cl::CircularList, n::Int64)
    length = cl.length

    cl.head += n
    if cl.head > length
        cl.head = cl.head%length
    end
end

function push!(cl::CircularList, data)
    movePtr(cl, 1)
    cl.data[cl.head] = data
end
