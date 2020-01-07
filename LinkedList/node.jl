import Base: show

mutable struct Node
    data::Union{Number, Nothing}
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
