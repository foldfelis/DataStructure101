mutable struct Node
    data::Union{Any, Nothing}
    prev::Union{Node, Nothing}
    next::Union{Node, Nothing}

    Node(data) = new(data, nothing, nothing)
end

function show(io::IO, node::Node)
    if node.prev != nothing
        print("PrevNode($(node.prev.data)) => ")
    else
        print("Nothing => ")
    end

    print("Node($(node.data)) => ")

    if node.next != nothing
        print("NextNode($(node.next.data))")
    else
        print("Nothing")
    end
end

mutable struct LinkedList
    current_node::Node
    LinkedList(data) = new(Node(data))
end

function head(ll::LinkedList)
    node = ll.current_node
    while node.prev != nothing
        node = node.prev
    end

    return node
end

function tail(ll::LinkedList)
    node = ll.current_node
    while node.next != nothing
        node = node.next
    end

    return node
end

function length(ll::LinkedList)
    node = head(ll)
    i = 0
    while node != nothing
        i += 1
        node = node.next
    end

    return i
end

function show(io::IO, ll::LinkedList)
    println("LinkedList(")
    println("\t There are $(length(ll)) node in the LinkedList")

    print("\t [")
    node = head(ll)
    while node.next != nothing

        if node == ll.current_node
            print("*")
        end

        print("$(node.data), ")
        node = node.next
    end

    if node == ll.current_node
        print("*")
    end
    println("$(node.data)]")

    print(")")
end

function movePtr(ll::LinkedList, n)
    if n > 0
        while n != 0
            if ll.current_node.next == nothing
                break
            end
            ll.current_node = ll.current_node.next
            n -= 1
        end
    elseif n < 0
        while n != 0
            if ll.current_node.prev == nothing
                break
            end
            ll.current_node = ll.current_node.prev
            n += 1
        end
    end
end

function movePtr2head(ll::LinkedList)
    ll.current_node = head(ll)
end

function movePtr2tail(ll::LinkedList)
    ll.current_node = tail(ll)
end

function push!(ll::LinkedList, data)
    node = Node(data)
    if ll.current_node.next != nothing
        next = ll.current_node.next
    else
        next = nothing
    end

    ll.current_node.next = node
    if next != nothing
        next.prev = node
    end
    node.prev = ll.current_node
    node.next = next

    ll.current_node = node
end

function pushfirst!(ll::LinkedList, data)
    node = Node(data)
    current_node = head(ll)

    node.next = current_node
    current_node.prev = node

    ll.current_node = head(ll)
end

function insert!(ll::LinkedList, data, i::Int64)
    if i > 1
        movePtr2head(ll)
        movePtr(ll, i-2)
        push!(ll, data)
    elseif i < 0
        movePtr2tail(ll)
        movePtr(ll, i+1)
        push!(ll, data)
    else
        pushfirst!(ll, data)
    end
end

function delete!(ll::LinkedList)
    current_node = ll.current_node

    if current_node.prev != nothing
        current_node.prev.next = current_node.next
    end
    if current_node.next != nothing
        current_node.next.prev = current_node.prev
    end

    if current_node.next != nothing
        ll.current_node = current_node.next
    else
        ll.current_node = current_node.prev
    end

    return current_node.data
end

function delete!(ll::LinkedList, i::Int64)
    if i > 1
        movePtr2head(ll)
        movePtr(ll, i-2)
        current_data = delete!(ll)
        return current_data
    elseif i < 0
        movePtr2tail(ll)
        movePtr(ll, i+1)
        current_data = delete!(ll)
        return current_data
    else
        movePtr2head(ll)
        current_data = delete!(ll)
        return current_data
    end
end
