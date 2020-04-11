export AbstractNode, NullNode, ListNode, LinkedList

abstract type AbstractNode end

struct NullNode <: AbstractNode end

# value(node::NullNode) = nothing

next(node::NullNode) = NullNode()

# prev(node::NullNode) = NullNode()

Base.show(io::IO, node::NullNode) = nothing

mutable struct ListNode{T} <: AbstractNode
    data::T
    prev::AbstractNode
    next::AbstractNode

    ListNode{T}(data::T) where T = new(data, NullNode(), NullNode())
end

value(node::ListNode) = node.data

next(node::ListNode) = node.next

prev(node::ListNode) = node.prev

Base.show(io::IO, node::ListNode) = print(io, value(node))

mutable struct LinkedList{T}
    head_node::AbstractNode
    length::Int64
end

LinkedList{T}() where T = LinkedList{T}(NullNode(), 0)

Base.length(ll::LinkedList) = ll.length

is_empty(ll::LinkedList) = (ll.length < 1)

head(ll::LinkedList) = ll.head_node

function tail(ll::LinkedList)
    node = head(ll)
    while !(next(node) isa NullNode)
        node = next(node)
    end

    return node
end

function Base.show(io::IO, ll::LinkedList{T}) where T
    print(io, "LinkedList{$T}([")

    node = head(ll)
    while !(next(node) isa NullNode)
        print(io, "$node, ")
        node = next(node)
    end

    print(io, "$(node)])")
end

function Base.push!(ll::LinkedList, data::T) where T
    node = ListNode{T}(data)

    if is_empty(ll)
        ll.head_node = node
        ll.length += 1
        return
    end

    tail_node = tail(ll)
    tail_node.next = node
    node.prev = tail_node

    ll.length += 1
end

function Base.pushfirst!(ll::LinkedList, data::T) where T
    node = ListNode{T}(data)
    head_node = head(ll)
    ll.head_node = node

    if is_empty(ll)
        ll.length += 1
        return
    end

    head_node.prev = node
    node.next = head_node

    ll.length += 1
end

function Base.pop!(ll::LinkedList)
    is_empty(ll) && throw(BoundsError("List is empty."))

    tail_node = tail(ll)
    if !(tail_node.prev isa NullNode)
        tail_node.prev.next = NullNode()
    else
        ll.head_node = NullNode()
    end

    ll.length -= 1

    return value(tail_node)
end

function Base.popfirst!(ll::LinkedList)
    is_empty(ll) && throw(BoundsError("List is empty."))

    head_node = head(ll)
    if !(head_node.next isa NullNode) head_node.next.prev = NullNode() end

    ll.head_node = head_node.next
    ll.length -= 1

    return value(head_node)
end

function n_node(ll::LinkedList, n::Int64)
    if is_empty(ll) throw(BoundsError("List is empty.")) end
    if ll.length < n throw(BoundsError("Out of boundary.")) end

    node = head(ll)
    for index=2:n
        node = next(node)
    end

    return node
end

Base.getindex(ll::LinkedList, i::Int64) = value(n_node(ll, i))

function Base.setindex!(ll::LinkedList{T}, data::T, i::Int64) where T
    n_node(ll, i).data = data
end


# function Base.insert!(ll::LinkedList, data::T, i::Int64) where T
#     # TODO:
# end

# function Base.delete!(ll::LinkedList, i::Int64)
#     # TODO
# end
