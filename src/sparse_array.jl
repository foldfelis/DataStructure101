import Base

export ValueEntry, SparseArray

mutable struct ValueEntry{T}
    row_i::Int
    col_i::Int
    value::T

    ValueEntry{T}(row_i::Int, col_i::Int, value::T) where T = new(
        row_i, col_i, value
    )
end

mutable struct SparseArray{T}
    n_row::Int
    n_col::Int
    data::Vector{ValueEntry{T}}

    SparseArray{T}(n_row::Int, n_col::Int) where T = new(
        n_row, n_col, Vector{ValueEntry{T}}()
    )
end

function Base.show(io::IO, sa::SparseArray{T}) where T
    println(io, "SparseArray{$T}$(size(sa))[")
    for value in sa.data
        println(io, "\t[$(value.row_i), $(value.col_i)]: $(value.value)")
    end
    print(io, "]")
end

function checkboundary(sa::SparseArray, row_i::Int, col_i::Int)
    if row_i > sa.n_row || row_i < 1 return false end
    if col_i > sa.n_col || col_i < 1 return false end

    return true
end

function find(sa::SparseArray, row_i::Int, col_i::Int)
    for (i, valueentry) in enumerate(sa.data)
        if valueentry.row_i == row_i && valueentry.col_i == col_i
             return i
         end
    end

    return -1
end

function Base.push!(sa::SparseArray{T}, row_i::Int, col_i::Int, value::T) where T
    valueentry = ValueEntry{T}(row_i, col_i, value)
    push!(sa.data, valueentry)
end

function Base.setindex!(sa::SparseArray{T}, value::T, row_i::Int, col_i::Int) where T
    if !checkboundary(sa, row_i, col_i) throw(BoundsError()) end

    i = find(sa, row_i, col_i)
    if i != -1
        if value == 0
            deleteat!(sa.data, i)
            return
        end
        sa.data[i].value = value
    else
        if value == 0 return end
        push!(sa, row_i, col_i, value)
    end
end

function Base.getindex(sa::SparseArray{T}, row_i::Int, col_i::Int) where T
    if !checkboundary(sa, row_i, col_i) throw(BoundsError()) end

    i = find(sa, row_i, col_i)
    if i != -1 return sa.data[i].value end

    return zero(T)
end

Base.size(sa::SparseArray) = (sa.n_row, sa.n_col)

Base.length(sa::SparseArray) = length(sa.data)

Base.eltype(sa::SparseArray{T}) where {T} = T
