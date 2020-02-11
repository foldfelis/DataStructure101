@testset "Test SparseArray" begin
    n_row = 100
    n_col = 110

    # Initial a SparseArray with size(10, 11)
    T_e = Int64
    T = SparseArray{T_e}
    sa = T(n_row, n_col)
    @test sa isa T
    @test size(sa) == (n_row, n_col)
    @test length(sa) == 0

    # SetIndex test: SetIndex data into SparseArray
    sa[5, 4] = 54
    @test sa[5, 4] == 54
    @test length(sa) == 1

    # SetIndex test: SetIndex data into SparseArray at same place
    sa[5, 4] = 5454
    @test sa[5, 4] == 5454
    @test length(sa) == 1

    # SetIndex test: SetIndex many data into SparseArray
    sa = T(n_row, n_col)
    len = 0
    for i = 1:n_row
        for j = 1:n_col
            value = 1*10 + j
            sa[i, j] = value
            @test sa[i, j] == value
            len += 1
            @test length(sa) == len
        end
    end

    # SetIndex test: SetIndex many 0 into SparseArray
    len = length(sa)
    for i = 2:n_row
        for j = 2:n_col
            sa[i, j] = 0
            len -= 1
            @test length(sa) == len
        end
    end

    # Element type test
    @test eltype(sa) == T_e
end
