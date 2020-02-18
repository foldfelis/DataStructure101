#############
# Tree Node #
#############
mutable struct TreeNode{T} <: AbstractNode
    value::T
    index::Int
    parent::AbstractNode
    left::AbstractNode
    right::AbstractNode

    TreeNode{T}(value::T, index::Int) where T =
        new(value, index, NullNode(), NullNode(), NullNode())
end

function String(node::AbstractNode)
    if node isa NullNode return "" end

    return "$(node.value)"
end


function show(io::IO, node::TreeNode{T}) where T
    println(io, "TreeNode{$T}( index=$(node.index)")
    if !(node.parent isa NullNode)
        println(io, " Parent($(String(node.parent)))")
    else
        println(io, " Current node is root")
    end

    println(io, " \tNode($(String(node)))")

    if !(node.right isa NullNode)
        println(io, " \t\tRightChild($(String(node.right)))")
    else
        println(io, " \t\tNull")
    end

    if !(node.left isa NullNode)
        println(io, " \t\tLeftChild($(String(node.left)))")
    else
        println(io, " \t\tNull")
    end
    print(io, ")")
end

function level(node::AbstractNode)
    if node isa TreeNode
        return Int(floor(log2(node.index))+1)
    end

    return
end

leftchild(tn::TreeNode) = tn.left

rightchild(tn::TreeNode) = tn.right

value(tn::TreeNode) = tn.value

value(tn::NullNode) = nothing

###############
# Binary Tree #
###############
mutable struct BinaryTree{T}
    root::TreeNode{T}
    length::Int

    BinaryTree{T}(val::T, index::Int) where T = new(TreeNode{T}(val, index), 1)
end

BinaryTree{T}(root_val::T) where T = BinaryTree{T}(root_val, 1)

eltype(bt::BinaryTree{T}) where {T} = T

function show(io::IO, bt::BinaryTree{T}) where T
    println(io, "BinaryTree{$T}(\n$(tree_repr(bt.root))\n)")
end

tree_repr(node::NullNode, treestr="", level=0) = treestr

function tree_repr(node::TreeNode, treestr="", level=0)
    treestr = tree_repr(node.right, treestr, level+1)
    treestr = "$(treestr)\n$("\t"^level)TreeNode($(String(node)))"
    treestr = tree_repr(node.left, treestr, level+1)

    return treestr
end

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
    index = bt.length + 1
    node = TreeNode{T}(v, index)

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

function checkboundary(bt::BinaryTree, i::Int)
    if i > bt.length
        throw(BoundsError())
        return false
    end

    return true
end

function getindex(bt::BinaryTree, i::Int)
    if !checkboundary(bt, i) return NullNode() end

    path = calc_path(i)
    node = getpath(bt, path)

    return node
end

function leftchild(bt::BinaryTree, i::Int)
    if !checkboundary(bt, i) return NullNode() end

    return bt[i].left
end

function rightchild(bt::BinaryTree, i::Int)
    if !checkboundary(bt, i) return NullNode() end

    return bt[i].right
end

function value(bt::BinaryTree, i::Int)
    if !checkboundary(bt, i) return NullNode() end
    node = bt[i]

    return node.value
end

root(bt::BinaryTree) = bt.root
