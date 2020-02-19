mutable struct Heap{T}
    data::Vector{T}
    ismax_heap::Bool

    Heap{T}(ismax_heap::Bool) where T = new(T[], ismax_heap)
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

getindex(heap::Heap{T}, i::Int64) where T = heap.data[i]

setindex!(heap::Heap{T}, v::Int64, i::Int64) where T = (heap.data[i] = v)

length(heap::Heap{T}) where T = length(heap.data)

root(heap::Heap{T}) where T = 1

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

ismax(heap::Heap{T}) where T = heap.ismax_heap

function max_heapify!(heap::Heap{T}, i::Int64=1) where T
    right_index = rightchild(heap, i)
    left_index = leftchild(heap, i)

    if right_index != -1
        max_heapify!(heap, right_index)

        if heap[i] < heap[right_index]
            heap[i], heap[right_index] = heap[right_index], heap[i]
        end
    end
    if left_index != -1
        max_heapify!(heap, left_index)

        if heap[i] < heap[left_index]
            heap[i], heap[left_index] = heap[left_index], heap[i]
        end
    end
end

function min_heapify!(heap::Heap{T}, i::Int64=1) where T
    right_index = rightchild(heap, i)
    left_index = leftchild(heap, i)

    if right_index != -1
        min_heapify!(heap, right_index)

        if heap[i] > heap[right_index]
            heap[i], heap[right_index] = heap[right_index], heap[i]
        end
    end
    if left_index != -1
        min_heapify!(heap, left_index)

        if heap[i] > heap[left_index]
            heap[i], heap[left_index] = heap[left_index], heap[i]
        end
    end
end

function heapify!(heap::Heap{T}) where T
    if ismax(heap) max_heapify!(heap)
    else min_heapify!(heap)
    end
end

function push!(heap::Heap{T}, v::T) where T
    push!(heap.data, v)
    heapify!(heap)
end

function pop!(heap::Heap{T}) where T
    len = length(heap)
    heap[1], heap[len] = heap[len], heap[1]
    value = pop!(heap.data)
    heapify!(heap)

    return value
end

function sort!(heap::Heap{T}) where T
    sorted = []
    len = length(heap)
    for i=1:len
        push!(sorted, pop!(heap))
    end

    return sorted
end
