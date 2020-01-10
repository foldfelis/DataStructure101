mutable struct Stack
    data::Vector
    Stack(d) = new([d, nothing])
end

function show(io::IO, s::Stack)
    print("Stack([")
    for i in s.data
        if i != nothing
            print("$(i), ")
        end
    end
    print("end])")
end

function pop!(s::Stack)
    deleteat!(s.data, 1)
end

function push!(s::Stack, d)
    pushfirst!(s.data, d)
end
