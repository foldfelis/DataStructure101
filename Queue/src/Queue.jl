import Base: show

mutable struct Queue
   data::Vector
   Queue(d) = new([d])
end

function show(io::IO, q::Queue)
   print("Queue($(q.data))")
end

function pop!(q::Queue)
   deleteat!(q.data, 1)
end

function add!(q::Queue, d)
   push!(q.data, d)
end
