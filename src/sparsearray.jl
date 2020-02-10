mutable struct ValueEntry{T}
    row_i::Int
    col_i::Int
    index::Int
    value::T

    ValueEntry{T}(row_i::Int, col_i::Int, value::T) where T = new(
        row_i, col_i, row_i*10+col_i, value
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
        println(io, "\t",
            "row: $(value.row_i), ",
            "col: $(value.col_i), ",
            "value: $(value.value)")
    end
    print(io, "]")
end

function checkboundary(sa::SparseArray, row_i::Int, col_i::Int)
    if row_i > sa.n_row || row_i < 1
        throw(BoundsError())
        return false
    end

    if col_i > sa.n_col || col_i < 1
        throw(BoundsError())
        return false
    end

    return true
end

function existindex(sa::SparseArray, row_i::Int, col_i::Int)
    index = row_i*10+col_i
    for (i, valueentry) in enumerate(sa.data)
        if valueentry.index == index return (i, true) end
    end

    return (-1, false)
end

function sort!(data::Vector{ValueEntry{T}}) where T
    i = length(data)
    while i > 1
        if data[i].index > data[i-1].index break end

        data[i], data[i-1] = data[i-1], data[i]
        i -= 1
    end
end

function push!(sa::SparseArray{T}, row_i::Int, col_i::Int, value::T) where T
    valueentry = ValueEntry{T}(row_i, col_i, value)
    push!(sa.data, valueentry)
    ezbubblesort!(sa.data)
end

function setindex!(sa::SparseArray{T}, row_i::Int, col_i::Int, value::T) where T
    if !checkboundary(sa, row_i, col_i) return end

    (i, exist) = existindex(sa, row_i, col_i)
    if exist
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
    if !checkboundary(sa, row_i, col_i) return end

    index = row_i*10+col_i
    for valueentry in sa.data
        if index == valueentry.index return valueentry.value end
    end

    return 0
end

size(sa::SparseArray) = (sa.n_row, sa.n_col)

length(sa::SparseArray) = length(sa.data)

function eltype(sa::SparseArray{T}) where T
    types = []
    for valueentry in sa.data
        push!(types, (valueentry.row_i, valueentry.col_i, T))
    end

    return types
end
