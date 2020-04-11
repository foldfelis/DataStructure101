using Test
using DataStructure101
const DS = DataStructure101

@testset "Test Queue" begin

    # Initial a Queue with data '0'
    T_e = Int64
    T = DS.Queue{T_e}
    data= T_e[0]
    queue = T(0)
    @test queue.data == data

    # Type test
    @test queue isa T

    # Push test: Push data into queue 20 times by 1:20
    passed_check_data = []
    for i = 1:20
        push!(queue, i)
        push!(data, i)
        push!(passed_check_data, queue.data == data)
    end
    @test all(passed_check_data)

    # Pop test: Pop data from queue 5 times
    passed_check_data = []
    for i = 1:5
        pop!(queue)
        popfirst!(data)
        push!(passed_check_data, queue.data == data)
    end
    @test all(passed_check_data)

    # Show Test
    @test repr(queue) == "Queue(["*
        "5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]"*
    ")"

end
