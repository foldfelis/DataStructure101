mutable struct Queue{T}
   data::Vector{T}
   Queue{T}(d) where T = new(T[d])
end

function show(io::IO, q::Queue)
   print(io, "Queue($(q.data))")
end

function pop!(q::Queue)
   popfirst!(q.data)
end

function push!(q::Queue, d)
   push!(q.data, d)
end
