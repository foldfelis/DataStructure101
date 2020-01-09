import Base: show, push!, pushfirst!, pop!, popfirst!

mutable struct Deque
    data::Vector{Any}
    Deque(d) = new([d])
end

function show(io::IO, deque::Deque)
    print("Deque($(deque.data))")
end

function push!(deque::Deque, d)
    push!(deque.data, d)
end

function pushfirst!(deque::Deque, d)
    pushfirst!(deque.data, d)
end

function pop!(deque::Deque)
    data = pop!(deque.data)
    return data
end

function popfirst!(deque::Deque)
    data = popfirst!(deque.data)
    return data
end
