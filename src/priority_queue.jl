import Base

export PriorityQueue
export update!, pop_min!, pop_max!

mutable struct PriorityQueue{T}
    priority::MinMaxHeap{Int64}
    data::Vector{T}

    PriorityQueue{T}() where T = new(MinMaxHeap{Int64}(), T[])
end

function Base.show(io::IO, pq::PriorityQueue{T}) where T
    print(io, "PriorityQueue{$T}($(pq.data)")
end

function Base.push!(pq::PriorityQueue{T}, v::T) where T
    push!(pq.data, v)
    priority = length(pq.data)
    push_bubble!(pq.priority, priority)
end

Base.minimum(pq::PriorityQueue) = minimum(pq.priority) => pq.data[minimum(pq.priority)]

Base.maximum(pq::PriorityQueue) = maximum(pq.priority) => pq.data[maximum(pq.priority)]

function pop_min!(pq::PriorityQueue)
    pop_min!(pq.priority)
    pq.priority.data .-= 1

    return popfirst!(pq.data)
end

function pop_max!(pq::PriorityQueue)
    pop_max!(pq.priority)

    return pop!(pq.data)
end

function update!(pq::PriorityQueue, p::Int64, offset::Int64)
    space = offset > 0 ? 1 : -1
    for i = p:space:p+(offset-space)
        pq.data[i], pq.data[i+space] = pq.data[i+space], pq.data[i]
    end
end
