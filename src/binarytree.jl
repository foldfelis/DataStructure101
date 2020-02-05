#=
### Binary tree (node impl.)

* `Base.show` (in pre-order)
* `root`
* `leftchild`
* `rightchild`
* `value`
=#
mutable struct TreeNode{T} <: AbstractNode
    value::T
    parent::AbstractNode
    left::AbstractNode
    right::AbstractNode

    TreeNode{T}(value::T) where T = new(value, NullNode(), NullNode(), NullNode())
end

mutable struct BinaryTree{T}
    root::TreeNode{T}
    length::Int

    BinaryTree{T}(root_val::T) where T = new(TreeNode{T}(root_val), 1)
end

function findpath(index::Int, getparent=false)
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

function push!(bt::BinaryTree{T}, v::T) where T
    node = TreeNode{T}(v)

    index = bt.length + 1
    path = findpath(index)

    parent = bt.root
    for isright in path[1:end-1]
        if isright
            parent = parent.right
        else
            parent = parent.left
        end
    end

    node.parent = parent

    isright = path[end]
    if isright
        parent.right = node
    else
        parent.left = node
    end

    bt.length += 1
end