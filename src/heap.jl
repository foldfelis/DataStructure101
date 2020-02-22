abstract type Heap{T} end

mutable struct MaxHeap{T} <: Heap{T}
    data::Vector{T}
    heapified::Bool

    MaxHeap{T}() where T = new(T[], true)
end

mutable struct MinHeap{T} <: Heap{T}
    data::Vector{T}
    heapified::Bool

    MinHeap{T}() where T = new(T[], true)
end

function show(io::IO, heap::Heap{T}) where T
    print(io, "Heap{$T}(\n$(tree_repr(heap, root(heap), length(heap)))\n)")
end

function tree_repr(
    heap::Heap, i::Int64, n::Int64,
    treestr::String="", level::Int64=0)

    right_index = rightchild(heap, i)
    left_index = leftchild(heap, i)

    if right_index <= n
        treestr = tree_repr(heap, rightchild(heap, i), length(heap), treestr, level+1)
    end
    treestr = "$(treestr)\n$("\t"^level)HeapNode($(heap[i]))"
    if left_index <= n
        treestr = tree_repr(heap, leftchild(heap, i), length(heap), treestr, level+1)
    end

    return treestr
end

getindex(heap::Heap, i::Int64) = heap.data[i]

setindex!(heap::Heap{T}, v::T, i::Int64) where T = (heap.data[i] = v)

length(heap::Heap) = length(heap.data)

root(heap::Heap) = 1

function parent(heap::Heap, i::Int64)
    if i > length(heap) || i < 1 return -1 end

    return floor(Int, i/2)
end

leftchild(heap::Heap, i::Int64) = 2 * i

rightchild(heap::Heap, i::Int64) = 2 * i + 1

heapified(heap::Heap) = heap.heapified

function heapify!(heap::MaxHeap, i::Int64, n::Int64)
    largest_index = i
    right_index = rightchild(heap, i)
    left_index = leftchild(heap, i)

    if right_index <= n && heap[i] < heap[right_index]
        largest_index = right_index
    end
    if left_index <= n && heap[largest_index] < heap[left_index]
        largest_index = left_index
    end

    if largest_index != i
        heap[i], heap[largest_index] = heap[largest_index], heap[i]
        heapify!(heap, largest_index, n)
    end
end

function heapify!(heap::MinHeap, i::Int64, n::Int64)
    smallest_index = i
    right_index = rightchild(heap, i)
    left_index = leftchild(heap, i)

    if right_index <= n && heap[i] > heap[right_index]
        smallest_index = right_index
    end
    if left_index <= n && heap[smallest_index] > heap[left_index]
        smallest_index = left_index
    end

    if smallest_index != i
        heap[i], heap[smallest_index] = heap[smallest_index], heap[i]
        heapify!(heap, smallest_index, n)
    end
end

function build!(heap::Heap)
    if heapified(heap) return end

    len = length(heap)
    p = parent(heap, len)
    for i = p:-1:1
        heapify!(heap, i, len)
    end

    heap.heapified = true
end

function push!(heap::Heap{T}, v::T) where T
    push!(heap.data, v)
    heap.heapified = false
end

function pop!(heap::Heap)
    if !heapified(heap) throw("Not Heap") end

    len = length(heap)
    heap[1], heap[len] = heap[len], heap[1]
    value = pop!(heap.data)
    heapify!(heap, 1, len-1)

    return value
end

function sort!(heap::Heap{T}) where T
    if !heapified(heap) throw("Not Heap") end

    sorted = T[]
    len = length(heap)
    for i=1:len
        push!(sorted, pop!(heap))
    end

    return sorted
end
