@testset "Test Queue" begin

    # Initial a Queue with data '0'
    T_e = Int64
    T = Queue{T_e}
    queue = T(0)

    # Type test:
    @test queue isa T

    # Push test: Push data into queue 20 times by 1:20
    data= T_e[0]
    passed_checkdata = []
    for i = 1:20
        push!(queue, i)
        push!(data, i)
        push!(passed_checkdata, queue.data == data)
    end
    @test all(passed_checkdata)

    # Pop test: Pop data from queue 5 times
    passed_checkdata = []
    for i = 1:5
        pop!(queue)
        popfirst!(data)
        push!(passed_checkdata, queue.data == data)
    end
    @test all(passed_checkdata)

end
