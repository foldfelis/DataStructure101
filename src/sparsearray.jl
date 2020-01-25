#=
Sparse Matrix
* `Base.show`
* `Base.getindex`
* `Base.setindex!`
* `Base.length`
* `Base.size`
* `Base.eltype`
=#
abstract type AbstractRow{T} end
abstract type AbstractValueEntry{T} end

struct NullRowList{T} <: AbstractRow{T} end
struct NullValueEntry{T} <: AbstractValueEntry{T} end

mutable struct RowList{T} <: AbstractRow{T}
    nrow::Int64
    nextrow::AbstractRow{T}
    firstval::AbstractValueEntry{T}

    RowList{T}(nrow::Int64) where T =
        new(nrow, NullRowList{T}(), NullValueEntry{T}())
end

mutable struct ValueEntry{T} <: AbstractValueEntry{T}
    ncol::Int64
    value::T
    next::AbstractValueEntry{T}

    ValueEntry{T}(ncol::Int64, value::T) where T =
        new(ncol, value, NullValueEntry{T}())
end

mutable struct SparseArray{T}
    nrow::Int64
    ncol::Int64
    firstrow::AbstractRow{T}

    SparseArray{T}(nrow::Int64, ncol::Int64) where T =
        new(nrow, ncol, NullRowList{T}())
end

function setindex!(
    sa::SparseArray, value::T, index::Tuple{Int64, Int64}) where T

    valentry = ValueEntry{T}(index[2], value)

    rowlist = RowList{T}(index[1])
    rowlist.firstval = valentry

    row = sa.firstrow
    if row isa NullRowList # nothing inside
        sa.firstrow = rowlist
    elseif row.nrow > index[1] # first row is larger then pushed row
        rowlist.nextrow = row
        sa.firstrow = rowlist
    elseif row.nrow == index[1] # first row is pushed row
        col = row.firstval
        if col.ncol > index[2] # first col is larger then pushed col
            valentry.next = col
            row.firseval = valentry
        elseif col.ncol == index[2] # first col is pushed col
            col.value = value
        else # first col is smaller then pushed col
            newnode = true
            while !(col.next isa NullValueEntry)
                if col.ncol == index[2]
                    col.value = value
                    newnode = false
                    break
                elseif col.next.ncol > index[2]
                    valentry.next = col.next
                    col.next = valentry
                    newnode = false
                    break
                end
                col = col.next
            end
            if newnode
                col.next = valentry
            end
        end
    else # first row is smaller then pushed row
        newrow = true
        while !(row.nextrow isa NullRowList)
            if row.nrow == index[1]
                col = row.firstval
                if col.ncol > index[2] # first col is larger then pushed col
                    valentry.next = col
                    row.firseval = valentry
                elseif col.ncol == index[2] # first col is pushed col
                    col.value = value
                else # first col is smaller then pushed col
                    newnode = true
                    while !(col.next isa NullValueEntry)
                        if col.ncol == index[2]
                            col.value = value
                            newnode = false
                            break
                        elseif col.next.ncol > index[2]
                            valentry.next = col.next
                            col.next = valentry
                            newnode = false
                            break
                        end
                        col = col.next
                    end
                    if newnode
                        col.next = valentry
                    end
                end
                newrow = false
                break
            elseif row.nextrow.nrow > index[1]
                rowlist.nextrow = row.nextrow
                row.nextrow = rowlist
                newrow = false
                break
            end
            row = row.nextrow
        end
        if newrow
            row.nextrow = rowlist
        end
    end
end
