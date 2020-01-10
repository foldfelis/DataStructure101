mutable struct Queue
   data::Vector
   Queue(d) = new([d])
end

function show(io::IO, q::Queue)
   print("Queue($(q.data))")
end

function pop!(q::Queue)
   popfirst!(q.data)
end

function push!(q::Queue, d)
   push!(q.data, d)
end
