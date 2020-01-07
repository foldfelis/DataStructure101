import Base: show, push!, +
include("node.jl")

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

function rear(ll::LinkedList)
    node = ll.current_node
    while node.next != nothing
        node = node.next
    end

    return node
end

function len(ll::LinkedList)
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
    println("\t There are $(len(ll)) node in the LinkedList")

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

function movePtr(ll::LinkedList, n)
    if n > 0
        while n != 0
            if ll.current_node.next == nothing
                break
            end
            ll.current_node = ll.current_noce.next
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
