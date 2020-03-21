import Base

export AbstractNode, NullNode, Node, LinkedList
export head, tail, move_ptr, move_ptr2head, move_ptr2tail

abstract type AbstractNode end

struct NullNode <: AbstractNode end

mutable struct Node{T} <: AbstractNode
    data::T
    prev::AbstractNode
    next::AbstractNode

    Node{T}(data::T) where T = new(data, NullNode(), NullNode())
end

function Base.show(io::IO, node::Node)
    if !(node.prev isa NullNode)
        print(io, "PrevNode($(node.prev.data)) => ")
    else
        print(io, "Null => ")
    end

    print(io, "Node($(node.data)) => ")

    if !(node.next isa NullNode)
        print(io, "NextNode($(node.next.data))")
    else
        print(io, "Null")
    end
end

mutable struct LinkedList{T}
    current_node::Node{T}
    LinkedList{T}(data::T) where T = new(Node{T}(data))
end

function head(ll::LinkedList)
    node = ll.current_node
    while !(node.prev isa NullNode)
        node = node.prev
    end

    return node
end

function tail(ll::LinkedList)
    node = ll.current_node
    while !(node.next isa NullNode)
        node = node.next
    end

    return node
end

function Base.length(ll::LinkedList)
    node = head(ll)
    i = 0
    while !(node isa NullNode)
        i += 1
        node = node.next
    end

    return i
end

function Base.show(io::IO, ll::LinkedList)
    println(io, "LinkedList(")
    println(io, "\t There are $(length(ll)) nodes in the LinkedList")

    print(io, "\t [")
    node = head(ll)
    while !(node.next isa NullNode)

        if node == ll.current_node
            print(io, "*")
        end

        print(io, "$(node.data), ")
        node = node.next
    end

    if node == ll.current_node
        print(io, "*")
    end
    println(io, "$(node.data)]")

    print(io, ")")
end

function move_ptr(ll::LinkedList, n)
    if n > 0
        while n != 0
            if ll.current_node.next isa NullNode
                break
            end
            ll.current_node = ll.current_node.next
            n -= 1
        end
    elseif n < 0
        while n != 0
            if ll.current_node.prev isa NullNode
                break
            end
            ll.current_node = ll.current_node.prev
            n += 1
        end
    end
end

function move_ptr2head(ll::LinkedList)
    ll.current_node = head(ll)
end

function move_ptr2tail(ll::LinkedList)
    ll.current_node = tail(ll)
end

function Base.push!(ll::LinkedList, data)
    T = typeof(data)
    node = Node{T}(data)
    if !(ll.current_node.next isa NullNode)
        next = ll.current_node.next
    else
        next = NullNode()
    end

    ll.current_node.next = node
    if !(next isa NullNode)
        next.prev = node
    end
    node.prev = ll.current_node
    node.next = next

    ll.current_node = node
end

function Base.pushfirst!(ll::LinkedList, data)
    T = typeof(data)
    node = Node{T}(data)
    current_node = head(ll)

    node.next = current_node
    current_node.prev = node

    ll.current_node = head(ll)
end

function Base.insert!(ll::LinkedList, data, i::Int64)
    if i > 1
        move_ptr2head(ll)
        move_ptr(ll, i-2)
        push!(ll, data)
    elseif i < 0
        move_ptr2tail(ll)
        move_ptr(ll, i+1)
        push!(ll, data)
    else
        pushfirst!(ll, data)
    end
end

function Base.delete!(ll::LinkedList)
    current_node = ll.current_node

    if !(current_node.prev isa NullNode)
        current_node.prev.next = current_node.next
    end
    if !(current_node.next isa NullNode)
        current_node.next.prev = current_node.prev
    end

    if !(current_node.next isa NullNode)
        ll.current_node = current_node.next
    else
        ll.current_node = current_node.prev
    end

    return current_node.data
end

function Base.delete!(ll::LinkedList, i::Int64)
    if i > 1
        move_ptr2head(ll)
        move_ptr(ll, i-2)
        current_data = delete!(ll)
        return current_data
    elseif i < 0
        move_ptr2tail(ll)
        move_ptr(ll, i+1)
        current_data = delete!(ll)
        return current_data
    else
        move_ptr2head(ll)
        current_data = delete!(ll)
        return current_data
    end
end
