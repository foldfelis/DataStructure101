using Test
using DataStructure101
const DS = DataStructure101

@testset "Test CircularQueue" begin

    # Initial a Circular Queue with mamery=5
    T_e = Int64
    T = DS.CircularQueue{T_e}
    mem = 5
    cl = T(mem)

    @test cl isa T
    @test length(cl) == 0
    @test size(cl) == mem
    @test repr(cl) == "CircularQueue{Int64, mem:0/5}([])"

    # Initial test data
    head_index = 0
    len = 0

    # Push test: Push data into CircularQueue 3 times by 1:3
    for i = 1:3
        pushfirst!(cl, i)

        head_index += 1
        len += 1

        @test cl.data[head_index] == i
        @test cl.head == head_index
        @test length(cl) == len
        @test size(cl) == mem
    end

    @test repr(cl) == "CircularQueue{Int64, mem:3/5}([3, 2, 1, ])"

    # Pop test
    real_data = cl.data
    for i = 1:7
        data = pop!(cl)

        if len > 0
            len -= 1
            @test data == i
        else
            @test data == nothing
        end

        @test cl.data == real_data
        @test cl.head == head_index
        @test length(cl) == len
        @test size(cl) == mem
    end

    @test repr(cl) == "CircularQueue{Int64, mem:0/5}([])"

    # Push test: Push data into CircularQueue 3 times by 1:4
    for i = 1:3
        pushfirst!(cl, i)

        head_index %= mem
        head_index += 1
        len += 1

        @test cl.data[head_index] == i
        @test cl.head == head_index
        @test length(cl) == len
        @test size(cl) == mem
    end

    @test repr(cl) == "CircularQueue{Int64, mem:3/5}([3, 2, 1, ])"
    @test cl.data == [3, 2, 3, 1, 2]
end
