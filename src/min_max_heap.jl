const DS = DataStructure101

export MinMaxHeap
export pop_min!, pop_max!, bubble_up!, push_bubble!

mutable struct MinMaxHeap <: DS.Heap
    data::Vector{Int64}
    heapified::Bool

    MinMaxHeap() = new(Int64[], true)
end

is_min_level(heap::MinMaxHeap, i::Int64) = isodd(DS.level(heap, i))

Base.minimum(heap::MinMaxHeap) = DS.heapified(heap) ? heap.data[1] : throw("Not Heap")

function Base.maximum(heap::MinMaxHeap)
    !DS.heapified(heap) && throw("Not Heap")
    return (heap.data[2] > heap.data[3] ? heap.data[2] : heap.data[3])
end

function min_heapify!(heap::MinMaxHeap, i::Int64, n::Int64)
    smallest_i = i

    right_i = DS.right_child(heap, i)
    right_grand_right_i = DS.right_child(heap, right_i)
    right_grand_left_i = DS.left_child(heap, right_i)
    left_i = DS.left_child(heap, i)
    left_grand_right_i = DS.right_child(heap, left_i)
    left_grand_left_i = DS.left_child(heap, left_i)

    (right_i <= n && heap[i] > heap[right_i]) &&
        (smallest_i = right_i)
    (right_grand_right_i <= n && heap[smallest_i] > heap[right_grand_right_i]) &&
        (smallest_i = right_grand_right_i)
    (right_grand_left_i <= n && heap[smallest_i] > heap[right_grand_left_i]) &&
        (smallest_i = right_grand_left_i)
    (left_i <= n && heap[smallest_i] > heap[left_i]) &&
        (smallest_i = left_i)
    (left_grand_right_i <= n && heap[smallest_i] > heap[left_grand_right_i]) &&
        (smallest_i = left_grand_right_i)
    (left_grand_left_i <= n && heap[smallest_i] > heap[left_grand_left_i]) &&
        (smallest_i = left_grand_left_i)

    (smallest_i == i) && return

    if smallest_i != right_i && smallest_i != left_i # smallest is grand child
        (heap[smallest_i] >= heap[i]) && return

        heap[smallest_i], heap[i] = heap[i], heap[smallest_i]
        p = DS.parent(heap, smallest_i)
        if heap[smallest_i] > heap[p]
            heap[smallest_i], heap[p] = heap[p], heap[smallest_i]
        end
        min_heapify!(heap, smallest_i, n)
    elseif heap[smallest_i] < heap[i] # smallest is child
        heap[smallest_i], heap[i] = heap[i], heap[smallest_i]
    end
end

function max_heapify!(heap::MinMaxHeap, i::Int64, n::Int64)
    largest_i = i

    right_i = DS.right_child(heap, i)
    right_grand_right_i = DS.right_child(heap, right_i)
    right_grand_left_i = DS.left_child(heap, right_i)
    left_i = DS.left_child(heap, i)
    left_grand_right_i = DS.right_child(heap, left_i)
    left_grand_left_i = DS.left_child(heap, left_i)

    (right_i <= n && heap[i] < heap[right_i]) &&
        (largest_i = right_i)
    (right_grand_right_i <= n && heap[largest_i] < heap[right_grand_right_i]) &&
        (largest_i = right_grand_right_i)
    (right_grand_left_i <= n && heap[largest_i] < heap[right_grand_left_i]) &&
        (largest_i = right_grand_left_i)
    (left_i <= n && heap[largest_i] < heap[left_i]) &&
        (largest_i = left_i)
    (left_grand_right_i <= n && heap[largest_i] < heap[left_grand_right_i]) &&
        (largest_i = left_grand_right_i)
    (left_grand_left_i <= n && heap[largest_i] < heap[left_grand_left_i]) &&
        (largest_i = left_grand_left_i)

    (largest_i == i) && return

    if largest_i != right_i && largest_i != left_i # largest is grand child
        (heap[largest_i] <= heap[i]) && return

        heap[largest_i], heap[i] = heap[i], heap[largest_i]
        p = DS.parent(heap, largest_i)
        if heap[largest_i] < heap[p]
            heap[largest_i], heap[p] = heap[p], heap[largest_i]
        end
        max_heapify!(heap, largest_i, n)
    elseif heap[largest_i] > heap[i] # largest is child
        heap[largest_i], heap[i] = heap[i], heap[largest_i]
    end
end

function heapify!(heap::MinMaxHeap, i::Int64, n::Int64)
    return is_min_level(heap, i) ? min_heapify!(heap, i, n) : max_heapify!(heap, i, n)
end

function pop_min!(heap::MinMaxHeap)
    !DS.heapified(heap) && throw("Not Heap")

    len = length(heap)
    heap[1], heap[len] = heap[len], heap[1]
    value = pop!(heap.data)
    heapify!(heap, 1, len-1)

    return value
end

function pop_max!(heap::MinMaxHeap)
    !DS.heapified(heap) && throw("Not Heap")

    index = heap.data[2] > heap.data[3] ? 2 : 3

    len = length(heap)
    heap[index], heap[len] = heap[len], heap[index]
    value = pop!(heap.data)
    heapify!(heap, index, len-1)

    return value
end

function min_bubble_up!(heap::MinMaxHeap, i::Int64)
    gp = DS.parent(heap, DS.parent(heap, i))
    !(gp > 0 && heap[i] < heap[gp]) && return

    heap[i], heap[gp] = heap[gp], heap[i]
    min_bubble_up!(heap, gp)
end

function max_bubble_up!(heap::MinMaxHeap, i::Int64)
    gp = DS.parent(heap, DS.parent(heap, i))
    !(gp > 0 && heap[i] > heap[gp]) && return

    heap[i], heap[gp] = heap[gp], heap[i]
    max_bubble_up!(heap, gp)
end

function bubble_up!(heap::MinMaxHeap, i::Int64)
    (i <= 1) && return

    p = DS.parent(heap, i)
    if is_min_level(heap, i)
        if heap[i] > heap[p]
            heap[i], heap[p] = heap[p], heap[i]
            max_bubble_up!(heap, p)
        else
            min_bubble_up!(heap, i)
        end
    else
        if heap[i] < heap[p]
            heap[i], heap[p] = heap[p], heap[i]
            min_bubble_up!(heap, p)
        else
            max_bubble_up!(heap, i)
        end
    end
end

function push_bubble!(heap::MinMaxHeap, v::Int64)
    push!(heap, v)
    bubble_up!(heap, length(heap))
    heap.heapified = true
end
