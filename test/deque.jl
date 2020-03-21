@testset "Test Deque" begin

    # Initial a Deque with data '0'
    T_e = Int64
    T = Deque{T_e}
    data= T_e[0]
    deque = T(0)
    @test deque.data == data

    #Type test:
    @test deque isa T

    # Push test: Push data into deque 20 times by 1:20
    passed_check_data = []
    for i = 1:20
        push!(deque, i)
        push!(data, i)
        push!(passed_check_data, deque.data == data)
    end
    @test all(passed_check_data)

    # Pushfirst test: Push data into deque 20 times by 31:35
    for i = 31:35
        pushfirst!(deque, i)
        pushfirst!(data, i)
        push!(passed_check_data, deque.data == data)
    end
    @test all(passed_check_data)

    # Pop test: Pop data from tail of deque
    passed_pop = [
        pop!(deque) == pop!(data),
        deque.data == data
    ]
    @test all(passed_pop)

    # Pop test: Pop data from head of deque
    passed_pop = [
        popfirst!(deque) == popfirst!(data),
        deque.data == data
    ]
    @test all(passed_pop)

    @test repr(deque) == "Deque(["*
    "34, 33, 32, 31, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19"*
    "])"

end
