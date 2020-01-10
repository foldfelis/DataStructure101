mutable struct CircularList{T}
    current_node::Node{T}

    function CircularList{T}(data::T) where T
        node = Node{T}(data)
        node.next = node
        node.prev = node

        return new(node)
    end
end

function show(io::IO, cl::CircularList)
    print("CircularList([..., ")

    current = cl.current_node
    while current.next != cl.current_node
        print("$(current.data), ")
        current = current.next
    end
    print("$(current.data), ...])")
end

function movePtr(cl::CircularList, n)
    if n > 0
        while n != 0
            cl.current_node = cl.current_node.next
            n -= 1
        end
    elseif n < 0
        while n != 0
            cl.current_node = cl.current_node.prev
            n += 1
        end
    end
end

function push!(cl::CircularList, data)
    T = typeof(data)
    node = Node{T}(data)
    current = cl.current_node

    node.next = current
    node.prev = current.prev
    current.prev = node
    node.prev.next = node

    cl.current_node = node
end

function push!(cl::CircularList, data, i::Int64)
    if i > 0    # To match the Jilia index system
        i -= 1
    end
    movePtr(cl, i)

    push!(cl, data)
end

function delete!(cl::CircularList)
    current = cl.current_node

    current.next.prev = current.prev
    current.prev.next = current.next

    cl.current_node = current.next

    return current.data
end

function delete!(cl::CircularList, i::Int64)
    if i > 0    # To match the Jilia index system
        i -= 1
    end
    movePtr(cl, i)

    return delete!(cl)
end
