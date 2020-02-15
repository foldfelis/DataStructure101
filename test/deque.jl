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
    passed_checkdata = []
    for i = 1:20
        push!(deque, i)
        push!(data, i)
        push!(passed_checkdata, deque.data == data)
    end
    @test all(passed_checkdata)

    # Pushfirst test: Push data into deque 20 times by 31:35
    for i = 31:35
        pushfirst!(deque, i)
        pushfirst!(data, i)
        push!(passed_checkdata, deque.data == data)
    end
    @test all(passed_checkdata)

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

end
