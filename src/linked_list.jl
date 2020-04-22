export AbstractNode, NullNode, ListNode, LinkedList

abstract type AbstractNode{T} end
const AbstractNullNode = AbstractNode{Any}

struct NullNode <: AbstractNullNode end

value(node::NullNode) = nothing

next(node::NullNode) = NullNode()

prev(node::NullNode) = NullNode()

Base.show(io::IO, node::NullNode) = nothing

mutable struct ListNode{T} <: AbstractNode{T}
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

function Base.show(io::IO, ll::LinkedList{T}) where T
    print(io, "LinkedList{$T}([")

    node = head(ll)
    while !(next(node) isa NullNode)
        print(io, "$node, ")
        node = next(node)
    end

    print(io, "$(node)])")
end

function _getindex(ll::LinkedList, n::Int64)
    if is_empty(ll) throw(BoundsError("List is empty.")) end
    if !(0 < n <= ll.length) throw(BoundsError("Out of boundary.")) end

    node = head(ll)
    for index=2:n
        node = next(node)
    end

    return node
end

Base.getindex(ll::LinkedList, i::Int64) = value(_getindex(ll, i))

function Base.setindex!(ll::LinkedList{T}, data::T, i::Int64) where T
    _getindex(ll, i).data = data
end

function Base.pushfirst!(ll::LinkedList, data::T) where T
    node = ListNode{T}(data)
    head_node = head(ll)
    ll.head_node = node

    if !is_empty(ll)
        head_node.prev = node
        node.next = head_node
    end

    ll.length += 1
end

function Base.insert!(ll::LinkedList, data::T, i::Int64) where T
    if i < 1
        throw(BoundsError("Out of boundary."))
    elseif i < 2
        Base.pushfirst!(ll, data)
    else
        node = ListNode{T}(data)
        current_node = _getindex(ll, i-1)
        next_node = next(current_node)

        node.prev = current_node
        current_node.next = node
        node.next = next_node
        !(next_node isa NullNode) && (next_node.prev = node)

        ll.length += 1
    end
end

function Base.push!(ll::LinkedList, data::T) where T
    is_empty(ll) ? Base.pushfirst!(ll, data) : Base.insert!(ll, data, ll.length+1)
end

function Base.popfirst!(ll::LinkedList)
    is_empty(ll) && throw(BoundsError("List is empty."))

    head_node = head(ll)
    if !(head_node.next isa NullNode) head_node.next.prev = NullNode() end

    ll.head_node = next(head_node)
    ll.length -= 1

    return value(head_node)
end

function Base.delete!(ll::LinkedList, i::Int64)
    if i < 1
        throw(BoundsError("Out of boundary."))
    elseif i < 2
        return Base.popfirst!(ll)
    else
        current_node = _getindex(ll, i)
        prev_node = prev(current_node)
        next_node = next(current_node)

        !(next_node isa NullNode) && (next_node.prev = prev_node)
        !(prev_node isa NullNode) && (prev_node.next = next_node)

        ll.length -= 1

        return value(current_node)
    end
end

Base.pop!(ll::LinkedList) = Base.delete!(ll, ll.length)
