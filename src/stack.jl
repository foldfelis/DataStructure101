export Stack

mutable struct Stack{T}
    data::Vector{T}
    Stack{T}(d::T) where T = new(T[d])
end

function Base.show(io::IO, s::Stack)
    print(io, "Stack([")
    for (i, x) in enumerate(s.data)
        print(io, "$(x)")
        if i != length(s.data)
            print(io, ", ")
        end
    end
    print(io, "])")
end

Base.pop!(s::Stack) = deleteat!(s.data, 1)

Base.push!(s::Stack, d) = pushfirst!(s.data, d)
