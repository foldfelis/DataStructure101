export Queue

mutable struct Queue{T}
   data::Vector{T}
   Queue{T}(d) where T = new(T[d])
end

function Base.show(io::IO, q::Queue)
   print(io, "Queue($(q.data))")
end

function Base.pop!(q::Queue)
   popfirst!(q.data)
end

function Base.push!(q::Queue, d)
   push!(q.data, d)
end
