#=
Sparse Matrix
* `Base.show`
* `Base.getindex`
* `Base.setindex!`
* `Base.length`
* `Base.size`
* `Base.eltype`
=#
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
    println(io, "SparseArray{$T}($(sa.n_row), $(sa.n_col))[")
    for value in sa.data
        println(io, "\t",
            "row: $(value.row_i), ",
            "col: $(value.col_i), ",
            "value: $(value.value)")
    end
    println(io, "]")
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

function ezbubblesort!(data::Vector{ValueEntry{T}}) where T
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
        sa.data[i].value = value
    else
        push!(sa, row_i, col_i, value)
    end
end