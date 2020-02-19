#=
- [ ] `Base.show(io, ::Heap)` (in vector)
- [x] `root(::Heap)`
- [x] `leftchild(::Heap, ::Int)`
- [x] `rightchild(::Heap, ::Int)`
- [x] `getindex(::Heap, ::Int)`
- [x] `heapify!(::Heap, ::Int)`
- [ ] `sort!(::Heap)`
- [x] `push!(::Heap{T}, ::T)`
- [ ] `pop!(::Heap)`
=#

mutable struct Heap{T}
    data::Vector{T}
    is_max_heap::Bool

    Heap{T}(is_max_heap::Bool) where T = new(T[], is_max_heap)
end

function show(io::IO, heap::Heap{T}) where T
    print(io, "Heap{$T}(\n$(tree_repr(heap, root(heap)))\n)")
end

function tree_repr(
    heap::Heap{T}, i::Int64,
    treestr::String="", level::Int64=0) where T

    right_index = rightchild(heap, i)
    left_index = leftchild(heap, i)

    if right_index != -1
        treestr = tree_repr(heap, rightchild(heap, i), treestr, level+1)
    end
    treestr = "$(treestr)\n$("\t"^level)HeapNode($(heap[i]))"
    if left_index != -1
        treestr = tree_repr(heap, leftchild(heap, i), treestr, level+1)
    end

    return treestr
end

root(heap::Heap{T}) where T = 1

getindex(heap::Heap{T}, i::Int64) where T = heap.data[i]

setindex!(heap::Heap{T}, v::Int64, i::Int64) where T = heap.data[i] = v

length(heap::Heap{T}) where T = length(heap.data)

function leftchild(heap::Heap{T}, i::Int64) where T
    index = 2 * i
    if index > length(heap) return -1 end

    return index
end

function rightchild(heap::Heap{T}, i::Int64) where T
    index = 2 * i + 1
    if index > length(heap) return -1 end

    return index
end

is_max(heap::Heap{T}) where T = heap.is_max_heap

function swap!(heap::Heap{T}, index1::Int64, index2::Int64) where T
    if index1 == -1 || index2 == -1 return end

    if heap[index1] < heap[index2]
        heap[index1], heap[index2] = heap[index2], heap[index1]
    end
end

function max_heapify!(heap::Heap{T}, i::Int64=1) where T
    right_index = rightchild(heap, i)
    left_index = leftchild(heap, i)

    if right_index != -1 max_heapify!(heap, right_index) end
    if left_index != -1 max_heapify!(heap, left_index) end

    swap!(heap, i, right_index)
    swap!(heap, i, left_index)
end

function min_heapify!(heap::Heap{T}, i::Int64=1) where T
    right_index = rightchild(heap, i)
    left_index = leftchild(heap, i)

    if right_index != -1 min_heapify!(heap, right_index) end
    if left_index != -1 min_heapify!(heap, left_index) end

    swap!(heap, right_index, i)
    swap!(heap, left_index, i)
end

function heapify!(heap::Heap{T}) where T
    if is_max(heap) max_heapify!(heap)
    else min_heapify!(heap)
    end
end

function push!(heap::Heap{T}, v::T) where T
    push!(heap.data, v)
    heapify!(heap)
end