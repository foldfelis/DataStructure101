@testset "Test Stack" begin

    # Initial a Stack with data '0'
    T_e = Int64
    T = Stack{T_e}
    stake = T(0)

    # Type test
    @test stake isa T

    # Push test: Push data into stake 20 times by 1:20
    data= T_e[0]
    passed_check_data = []
    for i = 1:20
        push!(stake, i)
        pushfirst!(data, i)
        push!(passed_check_data, stake.data == data)
    end
    @test all(passed_check_data)

    # Pop test: Pop data from stack 5 times
    passed_check_data = []
    for i = 1:5
        pop!(stake)
        deleteat!(data, 1)
        push!(passed_check_data, stake.data == data)
    end
    @test all(passed_check_data)

    @test repr(stake) == "Stack([15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0])"

end
