const DS = DataStructure101

export TreeNode, BinaryTree
export value, parent, left_child, right_child, level
export root, tree_repr

mutable struct TreeNode{T} <: DS.AbstractNode
    value::T
    parent::DS.AbstractNode
    left::DS.AbstractNode
    right::DS.AbstractNode

    TreeNode{T}(value::T) where T =new(
        value,
        DS.NullNode(),
        DS.NullNode(),
        DS.NullNode()
    )
end

value(tn::TreeNode) = tn.value

parent(tn::TreeNode) = tn.parent

left_child(tn::TreeNode) = tn.left

right_child(tn::TreeNode) = tn.right

parent(tn::DS.NullNode) = DS.NullNode()

left_child(tn::DS.NullNode) = DS.NullNode()

right_child(tn::DS.NullNode) = DS.NullNode()

function Base.show(io::IO, node::DS.TreeNode{T}) where T
    print(io, "TreeNode{$T}($(value(node)))")
end

function level(node::DS.AbstractNode)
    !(node isa DS.TreeNode) && (return -1)

    level = 0
    while !(parent(node) isa DS.NullNode)
        node = parent(node)
        level += 1
    end

    return level
end

mutable struct BinaryTree
    root::DS.AbstractNode
    length::Int
end

BinaryTree(value::Int64) = BinaryTree(TreeNode{Int64}(value), 1)

BinaryTree() = BinaryTree(DS.NullNode(), 0)

root(bt::BinaryTree) = bt.root

Base.length(bt::BinaryTree) = bt.length

Base.eltype(bt::BinaryTree) = Int64

tree_repr(node::DS.NullNode; tree_str="", level=0) = "$(tree_str)\n"

function tree_repr(node::TreeNode; tree_str="", level=0)
    tree_str = tree_repr(node.right, tree_str=tree_str, level=level+1)
    tree_str = "$(tree_str)\n$("\t"^level)TreeNode($(value(node)))"
    tree_str = tree_repr(node.left, tree_str=tree_str, level=level+1)

    return tree_str
end

function Base.show(io::IO, bt::BinaryTree)
    print(io, "BinaryTree($(tree_repr(bt.root)))")
end

function Base.getindex(bt::BinaryTree, i::Int)
    # calculate path
    path = []
    while i != 1
        push!(path, rem(i, 2))
        i = div(i, 2)
    end

    path = BitArray(reverse(path))

    # search node
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

function Base.setindex!(bt::BinaryTree, v::Int64, i::Int64)
    node = TreeNode{Int64}(v)
    (bt.root isa DS.NullNode && i == 1) && (bt.root = node; return)

    parent = Base.getindex(bt, div(i, 2))
    is_right = Bool(rem(i, 2))
    !(parent isa TreeNode) && (throw(BoundsError("parent of $(i)th node not found")))
    node.parent = parent
    is_right ? (parent.right = node) : (parent.left = node)

    bt.length += 1
end
