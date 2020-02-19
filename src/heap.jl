##################################
# Heap with Array representation #
##################################
#=
- [ ] `Base.show(io, ::Heap)` (in vector)
- [x] `root(::Heap)`
- [ ] `leftchild(::Heap, ::Int)`
- [ ] `rightchild(::Heap, ::Int)`
- [ ] `getindex(::Heap, ::Int)`
- [ ] `heapify!(::Heap, ::Int)`
- [ ] `sort!(::Heap)`
- [ ] `push!(::Heap{T}, ::T)`
- [ ] `pop!(::Heap)`
=#

mutable struct Heap{T}
    data::Vector{T}

    Heap{T}() where T = new(T[])
end

root(heap::Heap{T}) where T = heap.data[1]

function heapify!(heap::Heap{T}) where T
end



#######################################
# Heap with LinkedList representation #
#######################################
#=
- [x] `Base.show(io, ::Heap)` (in vector)
- [x] `root(::Heap)`
- [x] `leftchild(::Heap, ::Int)`
- [x] `rightchild(::Heap, ::Int)`
- [x] `getindex(::Heap, ::Int)`
- [x] `heapify!(::Heap, ::Int)`
- [ ] `sort!(::Heap)`
- [x] `push!(::Heap{T}, ::T)`
- [ ] `pop!(::Heap)`

mutable struct Heapll{T}
    bt::BinaryTree{T}
    ismaxheapll::Bool

    Heapll{T}(val::T) where T = new(BinaryTree{T}(val), true)
end

root(heapll::Heapll{T}) where T = root(heapll.bt)

function show(io::IO, heapll::Heapll{T}) where T
    print(io, "Heapll{$T}(")
    if heapll.ismaxheapll
        println(io, " [Max Heapll]")
    else
        println(io, " [Min Heapll]")
    end
    println(io, "$(tree_repr(root(heapll.bt)))\n)")
end

leftchild(heapll::Heapll{T}, i::Int64) where T = leftchild(heapll.bt, i)

rightchild(heapll::Heapll{T}, i::Int64) where T = rightchild(heapll.bt, i)

value(heapll::Heapll{T}, i::Int) where T = value(heapll.bt, i)

getindex(heapll::Heapll{T}, i::Int) where T = getindex(heapll.bt, i)

length(heapll::Heapll{T}) where T = heapll.bt.length

function swap!(heapll::Heapll{T}, i1::Int64, i2::Int64) where T
    node1 = getindex(heapll, i1)
    node2 = getindex(heapll, i2)

    node1.value, node2.value = node2.value, node1.value
end

heapify!(tn::NullNode, ismaxheapll::Bool) where T = nothing

function heapify!(tn::TreeNode{T}, ismaxheapll::Bool) where T
    left = leftchild(tn)
    right = rightchild(tn)
    if left isa NullNode && right isa NullNode return end

    heapify!(left, ismaxheapll)
    heapify!(right, ismaxheapll)

    if ismaxheapll
        if !(left isa NullNode)
            if value(left) > value(tn)
                left.value, tn.value = tn.value, left.value
            end
        end
        if !(right isa NullNode)
            if value(right) > value(tn)
                right.value, tn.value = tn.value, right.value
            end
        end
    else
        if !(left isa NullNode)
            if value(left) < value(tn)
                left.value, tn.value = tn.value, left.value
            end
        end
        if !(right isa NullNode)
            if value(right) < value(tn)
                right.value, tn.value = tn.value, right.value
            end
        end
    end
end

function heapify!(heapll::Heapll{T}) where T
    heapify!(root(heapll), heapll.ismaxheapll)
end

function push!(heapll::Heapll{T}, v::T) where T
    push!(heapll.bt, v)
    heapify!(heapll)
end
=#
