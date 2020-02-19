mutable struct Heap{T}
    data::Vector{T}
    ismax_heap::Bool

    Heap{T}(ismax_heap::Bool) where T = new(T[], ismax_heap)
end

function show(io::IO, heap::Heap{T}) where T
    print(io, "Heap{$T}(\n$(tree_repr(heap, root(heap), length(heap)))\n)")
end

function tree_repr(
    heap::Heap{T}, i::Int64, n::Int64,
    treestr::String="", level::Int64=0) where T

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

getindex(heap::Heap{T}, i::Int64) where T = heap.data[i]

setindex!(heap::Heap{T}, v::Int64, i::Int64) where T = (heap.data[i] = v)

length(heap::Heap{T}) where T = length(heap.data)

root(heap::Heap{T}) where T = 1

function parent(heap::Heap{T}, i::Int64) where T
    index = Int(floor(i/2))
    if index > length(heap) || index < 1 return -1 end

    return index
end

leftchild(heap::Heap{T}, i::Int64) where T = 2 * i

rightchild(heap::Heap{T}, i::Int64) where T = 2 * i + 1

ismax(heap::Heap{T}) where T = heap.ismax_heap

function max_heapify!(heap::Heap{T}, i::Int64, n::Int64) where T
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
        max_heapify!(heap, largest_index, n)
    end
end

function min_heapify!(heap::Heap{T}, i::Int64, n::Int64) where T
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
        min_heapify!(heap, smallest_index, n)
    end
end

function heapify!(heap::Heap{T}, n::Int64) where T
    if ismax(heap)
        for i = parent(heap, n):-1:1
            max_heapify!(heap, i, n)
        end
    else
        for i = parent(heap, n):-1:1
            min_heapify!(heap, i, n)
        end
    end
end

function push!(heap::Heap{T}, v::T) where T
    push!(heap.data, v)
    heapify!(heap, length(heap))
end

function pop!(heap::Heap{T}) where T
    len = length(heap)
    heap[1], heap[len] = heap[len], heap[1]
    value = pop!(heap.data)
    heapify!(heap, length(heap))

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
