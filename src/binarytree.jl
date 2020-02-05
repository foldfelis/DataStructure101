mutable struct TreeNode{T} <: AbstractNode
    value::T
    parent::AbstractNode
    left::AbstractNode
    right::AbstractNode

    TreeNode{T}(value::T) where T = new(value, NullNode(), NullNode(), NullNode())
end

function show(io::IO, node::TreeNode{T}) where T
    println(io, "TreeNode{$T}(")
    if !(node.parent isa NullNode)
        println(io, " Parent($(node.parent.value))")
    else
        println(io, " Current node is root")
    end

    println(io, " \tNode($(node.value))")

    if !(node.right isa NullNode)
        println(io, " \t\tRightChild($(node.right.value))")
    else
        println(io, " \t\tNull")
    end

    if !(node.left isa NullNode)
        println(io, " \t\tLeftChild($(node.left.value))")
    else
        println(io, " \t\tNull")
    end
    print(io, ")")
end

mutable struct BinaryTree{T}
    root::TreeNode{T}
    length::Int

    BinaryTree{T}(root_val::T) where T = new(TreeNode{T}(root_val), 1)
end

# TODO: function show(io::IO, bt::BinaryTree{T}) where T

function calc_path(index::Int, getparent=false)
    path = []
    while index != 1
        push!(path, rem(index, 2))
        index = div(index, 2)
    end

    path = BitArray(reverse(path))

    if getparent
        return path[1:end-1]
    else
        return path
    end
end

function getpath(bt::BinaryTree, path::BitArray)
    node = bt.root
    for isright in path
        if isright
            node = node.right
        else
            node = node.left
        end
    end

    return node
end

function push!(bt::BinaryTree{T}, v::T) where T
    node = TreeNode{T}(v)

    index = bt.length + 1
    path = calc_path(index)
    parent = getpath(bt, path[1:end-1])

    node.parent = parent

    isright = path[end]
    if isright
        parent.right = node
    else
        parent.left = node
    end

    bt.length += 1
end

function checklength(bt::BinaryTree, i::Int)
    if i > bt.length
        @error "BoundaryError"
        return false
    end

    return true
end

function getindex(bt::BinaryTree, i::Int)
    if !checklength(bt, i) return end

    path = calc_path(i)
    node = getpath(bt, path)

    return node
end

function leftchild(bt::BinaryTree, i::Int)
    if !checklength(bt, i) return end

    node = getindex(bt, i)
    if !(node.left isa NullNode)
        return node.left.value
    end

    return
end

function rightchild(bt::BinaryTree, i::Int)
    if !checklength(bt, i) return end

    node = getindex(bt, i)
    if !(node.right isa NullNode)
        return node.right.value
    end

    return
end

function value(bt::BinaryTree, i::Int)
    if !checklength(bt, i) return end

    node = getindex(bt, i)

    return node.value
end