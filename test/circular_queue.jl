@testset "Test CircularQueue" begin

    # Initial a Circular Queue with mamery=19
    T_e = Int64
    T = CircularQueue{T_e}
    mem = 19
    cl = T(mem)
    passed_initial = [
        cl.length == 0,
        cl.limit == mem,
    ]
    @test all(passed_initial)

    # Circular Queue type test
    @test cl isa T

    # Push test: Push data into CircularQueue 5 times by -5:-1
    passed_push = []
    headindex = 0
    for i = -5:-1
        pushfirst!(cl, i)

        headindex += 1
        push!(passed_push, cl.data[headindex] == i)
        push!(passed_push, cl.head == headindex)
        push!(passed_push, cl.tail == 1)
        push!(passed_push, cl.length == headindex)
        push!(passed_push, cl.limit == mem)
    end
    @test all(passed_push)

    # Pop test
    real_data = cl.data
    tailindex = 1
    len = 5
    passed_pop = []
    for i = -5:10
        data = pop!(cl)

        if tailindex <= headindex
            tailindex += 1
            len -= 1
            push!(passed_pop, data == i)
            push!(passed_pop, cl.tail == tailindex)
            push!(passed_pop, cl.length == len)
        end

        push!(passed_pop, cl.data == real_data)
        push!(passed_pop, cl.head == headindex)
        push!(passed_pop, cl.limit == mem)
    end
    @test all(passed_pop)

    # Push test: Push data into CircularQueue 25 times by 1:25
    for i = 1:25
        pushfirst!(cl, i)

        if headindex < mem headindex += 1 else headindex = 1 end
        push!(passed_push, cl.data[headindex] == i)
        push!(passed_push, cl.head == headindex)

        if i > mem
            len = mem
        else
            len = i
        end
        push!(passed_push, cl.length == len)

        # adjust tail
        tailindex = headindex
        tailindex -= 1
        tailindex -= len-1
        tailindex %= len
        if tailindex < 0
            tailindex += len
        end
        tailindex += 1
        push!(passed_push, cl.tail == tailindex)

        push!(passed_push, cl.limit == mem)
    end
    @test all(passed_push)

    # Pop test
    for i = 1:15
        data = pop!(cl)

        if tailindex <= headindex
            tailindex %= mem
            tailindex += 1
            push!(passed_pop, data == i)
            push!(passed_pop, cl.tail == tailindex)
            push!(passed_pop, cl.length == len)
        end

        push!(passed_pop, cl.data == real_data)
        push!(passed_pop, cl.head == headindex)
        push!(passed_pop, cl.limit == mem)
    end
    @test all(passed_pop)

end
