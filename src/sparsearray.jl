mutable struct ValueEntry{T}
    row_i::Int
    col_i::Int
    index::Tuple{Int64, Int64}
    value::T

    ValueEntry{T}(row_i::Int, col_i::Int, value::T) where T = new(
        row_i, col_i, (row_i, col_i), value
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

function show(io::IO, sa::SparseArray{T}) where T
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

function getexistindex(sa::SparseArray, row_i::Int, col_i::Int)
    index = (row_i, col_i)
    for (i, valueentry) in enumerate(sa.data)
        if valueentry.index == index return i end
    end

    return -1
end

function push!(sa::SparseArray{T}, row_i::Int, col_i::Int, value::T) where T
    valueentry = ValueEntry{T}(row_i, col_i, value)
    push!(sa.data, valueentry)
end

function setindex!(sa::SparseArray{T}, value::T, row_i::Int, col_i::Int) where T
    if !checkboundary(sa, row_i, col_i)
        throw(BoundsError())
        return
    end

    i = getexistindex(sa, row_i, col_i)
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

function getindex(sa::SparseArray{T}, row_i::Int, col_i::Int) where T
    if !checkboundary(sa, row_i, col_i)
        throw(BoundsError())
        return
    end

    index = (row_i, col_i)
    for valueentry in sa.data
        if index == valueentry.index return valueentry.value end
    end

    return 0
end

size(sa::SparseArray) = (sa.n_row, sa.n_col)

length(sa::SparseArray) = length(sa.data)

eltype(sa::SparseArray{T}) where {T} = T
