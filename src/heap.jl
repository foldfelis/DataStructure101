const DS = DataStructure101

export Heap, MaxHeap, MinHeap
export level, root, parent, left_child, right_child, heapify!, build!

abstract type Heap end

mutable struct MaxHeap <: Heap
    data::Vector{Int64}
    heapified::Bool

    MaxHeap() = new(Int64[], true)
end

mutable struct MinHeap <: Heap
    data::Vector{Int64}
    heapified::Bool

    MinHeap() = new(Int64[], true)
end

Base.getindex(heap::Heap, i::Int64) = heap.data[i]

Base.setindex!(heap::Heap, v::Int64, i::Int64) = (heap.data[i] = v)

Base.length(heap::Heap) = length(heap.data)

level(heap::Heap, i::Int64) = floor(Int, log2(i)) + 1

root(heap::Heap) = 1

parent(heap::Heap, i::Int64) = (i > length(heap) || i < 1) ? -1 : floor(Int, i/2)

left_child(heap::Heap, i::Int64) = 2 * i

right_child(heap::Heap, i::Int64) = 2 * i + 1

heapified(heap::Heap) = heap.heapified

function tree_repr(heap::Heap, i::Int64, n::Int64; tree_str::String="", level::Int64=0)
    right_index = right_child(heap, i)
    left_index = left_child(heap, i)
    length = Base.length(heap)

    (right_index <= n) && (tree_str = tree_repr(
        heap,
        right_index,
        length,
        tree_str=tree_str,
        level=level+1
    ))

    tree_str = "$(tree_str)\n$("\t"^level)HeapNode($(heap[i]))"

    (left_index <= n) && (tree_str = tree_repr(
        heap,
        left_index,
        length,
        tree_str=tree_str,
        level=level+1
    ))

    return tree_str
end

function Base.show(io::IO, heap::Heap)
    print(io, "Heap(\n$(tree_repr(heap, root(heap), length(heap)))\n)")
end

function heapify!(heap::MaxHeap, i::Int64, n::Int64)
    largest_index = i
    right_index = right_child(heap, i)
    left_index = left_child(heap, i)

    (right_index <= n && heap[i] < heap[right_index]) &&
        (largest_index = right_index)
    (left_index <= n && heap[largest_index] < heap[left_index]) &&
        (largest_index = left_index)

    if largest_index != i
        heap[i], heap[largest_index] = heap[largest_index], heap[i]
        heapify!(heap, largest_index, n)
    end
end

function heapify!(heap::MinHeap, i::Int64, n::Int64)
    smallest_index = i
    right_index = right_child(heap, i)
    left_index = left_child(heap, i)

    (right_index <= n && heap[i] > heap[right_index]) &&
        (smallest_index = right_index)
    (left_index <= n && heap[smallest_index] > heap[left_index]) &&
        (smallest_index = left_index)

    if smallest_index != i
        heap[i], heap[smallest_index] = heap[smallest_index], heap[i]
        heapify!(heap, smallest_index, n)
    end
end

function build!(heap::Heap)
    heapified(heap) && return

    len = length(heap)
    p = parent(heap, len)
    for i = p:-1:1
        heapify!(heap, i, len)
    end

    heap.heapified = true
end

function Base.push!(heap::Heap, v::Int64)
    push!(heap.data, v)
    heap.heapified = false
end

function Base.pop!(heap::Heap)
    !heapified(heap) && throw("Not Heap")

    len = length(heap)
    heap[1], heap[len] = heap[len], heap[1]
    value = pop!(heap.data)
    heapify!(heap, 1, len-1)

    return value
end

function Base.sort!(heap::Heap)
    !heapified(heap) && throw("Not Heap")

    sorted = Int64[]
    len = length(heap)
    for i=1:len
        push!(sorted, pop!(heap))
    end

    return sorted
end
