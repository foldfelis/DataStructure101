mutable struct PriorityQueue{T}
    priority::MinMaxHeap{Int64}
    data::Vector{T}

    PriorityQueue{T}() where T = new(MinMaxHeap{Int64}(), T[])
end

function show(io::IO, pq::PriorityQueue{T}) where T
    print(io, "PriorityQueue{$T}($(pq.data)")
end

function push!(pq::PriorityQueue{T}, v::T) where T
    push!(pq.data, v)
    priority = length(pq.data)
    pushbubble!(pq.priority, priority)
end

firstpriority(pq::PriorityQueue) = pq.data[minimum(pq.priority)]

lastpriority(pq::PriorityQueue) = pq.data[maximum(pq.priority)]

function popfirst!(pq::PriorityQueue)
    popmin!(pq.priority)
    pq.priority.data .-= 1

    return popfirst!(pq.data)
end

function pop!(pq::PriorityQueue)
    popmax!(pq.priority)

    return pop!(pq.data)
end
