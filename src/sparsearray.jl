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
    value::T
end

mutable struct SparseArray{T}
    nrow::Int
    ncol::Int
    data::Vector{ValueEntry{T}}

    SparseArray{T}(nrow::Int, ncol::Int) where T = new(
        nrow, ncol, Vector{ValueEntry{T}}()
    )
end

function show(io::IO, sa::SparseArray{T}) where T
    println(io, "SparseArray{$T}($(sa.nrow), $(sa.ncol))[")
    for value in sa.data
        println(io, "\t",
            "row: $(value.row_i), ",
            "col: $(value.col_i), ",
            "value: $(value.value)")
    end
    println(io, "]")
end
