#=
Sparse Matrix
* `Base.show`
* `Base.getindex`
* `Base.setindex!`
* `Base.length`
* `Base.size`
* `Base.eltype`
=#
abstract type AbstractRowList{T} end
abstract type AbstractValueList{T} end

struct NullRowList{T} <: AbstractRowList{T} end
struct NullValueList{T} <: AbstractValueList{T} end

mutable struct RowList{T} <: AbstractRowList{T}
    rownumber::Int64
    nextrow::AbstractRowList{T}
    rightval::AbstractValueList{T}
end

mutable struct ValueList{T} <: AbstractValueList{T}
    colnumber::Int64
    value::T
    next::AbstractValueList{T}
end

mutable struct SparseArray{T}
    rownumber::Int64
    colnumber::Int64
    firstrowlist::AbstractRowList{T}

    SparseArray{T}(rownumber::Int64, colnumber::Int64) where T =
        new(rownumber, colnumber, NullRowList{T}())
end
