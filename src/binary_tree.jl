const DS = DataStructure101

export TreeNode, BinaryTree
export value, left_child, right_child, root, tree_repr, level

mutable struct TreeNode{T} <: DS.AbstractNode
    value::T
    index::Int
    parent::DS.AbstractNode
    left::DS.AbstractNode
    right::DS.AbstractNode

    TreeNode{T}(value::T, index::Int) where T =
        new(value, index, DS.NullNode(), DS.NullNode(), DS.NullNode())
end

function Base.String(node::DS.AbstractNode)
    if node isa DS.NullNode return "" end

    return "$(node.value)"
end


function Base.show(io::IO, node::DS.TreeNode{T}) where T
    println(io, "TreeNode{$T}( index=$(node.index)")
    if !(node.parent isa DS.NullNode)
        println(io, " Parent($(String(node.parent)))")
    else
        println(io, " Current node is root")
    end

    println(io, " \tNode($(String(node)))")

    if !(node.right isa DS.NullNode)
        println(io, " \t\tRightChild($(String(node.right)))")
    else
        println(io, " \t\tNull")
    end

    if !(node.left isa DS.NullNode)
        println(io, " \t\tLeftChild($(String(node.left)))")
    else
        println(io, " \t\tNull")
    end
    print(io, ")")
end

function level(node::DS.AbstractNode)
    if node isa TreeNode
        return Int(floor(log2(node.index))+1)
    end

    return
end

left_child(tn::TreeNode) = tn.left

right_child(tn::TreeNode) = tn.right

value(tn::TreeNode) = tn.value

value(tn::DS.NullNode) = nothing

mutable struct BinaryTree{T}
    root::TreeNode{T}
    length::Int

    BinaryTree{T}(val::T, index::Int) where T = new(TreeNode{T}(val, index), 1)
end

BinaryTree{T}(root_val::T) where T = BinaryTree{T}(root_val, 1)

Base.eltype(bt::BinaryTree{T}) where {T} = T

function Base.show(io::IO, bt::BinaryTree{T}) where T
    println(io, "BinaryTree{$T}(\n$(tree_repr(bt.root))\n)")
end

tree_repr(node::DS.NullNode; tree_str="", level=0) = tree_str

function tree_repr(node::TreeNode; tree_str="", level=0)
    tree_str = tree_repr(node.right, tree_str=tree_str, level=level+1)
    tree_str = "$(tree_str)\n$("\t"^level)TreeNode($(String(node)))"
    tree_str = tree_repr(node.left, tree_str=tree_str, level=level+1)

    return tree_str
end

function calc_path(index::Int; get_parent=false)
    path = []
    while index != 1
        push!(path, rem(index, 2))
        index = div(index, 2)
    end

    path = BitArray(reverse(path))

    if get_parent
        return path[1:end-1]
    else
        return path
    end
end

function get_path(bt::BinaryTree, path::BitArray)
    node = bt.root
    for is_right in path
        if is_right
            node = node.right
        else
            node = node.left
        end
    end

    return node
end

function Base.push!(bt::BinaryTree{T}, v::T) where T
    index = bt.length + 1
    node = TreeNode{T}(v, index)

    path = calc_path(index)
    parent = get_path(bt, path[1:end-1])

    node.parent = parent

    isright = path[end]
    if isright
        parent.right = node
    else
        parent.left = node
    end

    bt.length += 1
end

function check_boundary(bt::BinaryTree, i::Int)
    if i > bt.length
        throw(BoundsError())
        return false
    end

    return true
end

function Base.getindex(bt::BinaryTree, i::Int)
    if !check_boundary(bt, i) return DS.NullNode() end

    path = calc_path(i)
    node = get_path(bt, path)

    return node
end

function left_child(bt::BinaryTree, i::Int)
    if !check_boundary(bt, i) return DS.NullNode() end

    return bt[i].left
end

function right_child(bt::BinaryTree, i::Int)
    if !check_boundary(bt, i) return DS.NullNode() end

    return bt[i].right
end

function value(bt::BinaryTree, i::Int)
    if !check_boundary(bt, i) return DS.NullNode() end
    node = bt[i]

    return node.value
end

root(bt::BinaryTree) = bt.root
