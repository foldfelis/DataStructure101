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
    @test eltype(sa) == T_e

    # SetIndex test: SetIndex data into SparseArray
    sa[5, 4] = 54
    @test sa[5, 4] == 54
    @test length(sa) == 1

    # SetIndex test: SetIndex data into SparseArray at same place
    sa[5, 4] = 5454
    @test sa[5, 4] == 5454
    @test length(sa) == 1

    # SetIndex test: SetIndex 0 into SparseArray and length shouldn't increase
    sa[6, 5] = 0
    @test sa[6, 5] == 0
    @test length(sa) == 1

    # SetIndex test: SetIndex many data into SparseArray
    sa = T(n_row, n_col)
    len = 0
    passed_check_value = []
    passed_check_length = []
    for i = 1:n_row
        for j = 1:n_col
            len += 1
            sa[i, j] = len
            push!(passed_check_value, sa[i, j] == len)
            push!(passed_check_length, length(sa) == len)
        end
    end
    @test all(passed_check_value)
    @test all(passed_check_length)

    # SetIndex test: SetIndex many 0 into SparseArray
    len = length(sa)
    passed_check_length = []
    for i = 2:n_row
        for j = 2:n_col
            sa[i, j] = 0
            len -= 1
            push!(passed_check_length, length(sa) == len)
        end
    end
    @test all(passed_check_length)

    new_sa = T(10, 5)
    new_sa[3, 3] = 53
    @test repr(new_sa) == "SparseArray{Int64}(10, 5)[\n\t[3, 3]: 53\n]"
end
