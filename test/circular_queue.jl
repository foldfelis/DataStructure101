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
    head_index = 0
    for i = -5:-1
        pushfirst!(cl, i)

        head_index += 1
        push!(passed_push, cl.data[head_index] == i)
        push!(passed_push, cl.head == head_index)
        push!(passed_push, cl.tail == 1)
        push!(passed_push, cl.length == head_index)
        push!(passed_push, cl.limit == mem)
    end
    @test all(passed_push)
    @test length(cl) == 5

    # Pop test
    real_data = cl.data
    tail_index = 1
    len = 5
    passed_pop = []
    for i = -5:10
        data = pop!(cl)

        if tail_index <= head_index
            tail_index += 1
            len -= 1
            push!(passed_pop, data == i)
            push!(passed_pop, cl.tail == tail_index)
            push!(passed_pop, cl.length == len)
        end

        push!(passed_pop, cl.data == real_data)
        push!(passed_pop, cl.head == head_index)
        push!(passed_pop, cl.limit == mem)
    end
    @test all(passed_pop)
    @test length(cl) == 0

    # Push test: Push data into CircularQueue 25 times by 1:25
    for i = 1:25
        pushfirst!(cl, i)

        if head_index < mem head_index += 1 else head_index = 1 end
        push!(passed_push, cl.data[head_index] == i)
        push!(passed_push, cl.head == head_index)

        if i > mem
            len = mem
        else
            len = i
        end
        push!(passed_push, cl.length == len)

        # adjust tail
        tail_index = head_index
        tail_index -= 1
        tail_index -= len-1
        tail_index %= len
        if tail_index < 0
            tail_index += len
        end
        tail_index += 1
        push!(passed_push, cl.tail == tail_index)

        push!(passed_push, cl.limit == mem)
    end
    @test all(passed_push)
    @test length(cl) == mem

    # Pop test
    for i = 1:15
        data = pop!(cl)

        if tail_index <= head_index
            tail_index %= mem
            tail_index += 1
            push!(passed_pop, data == i)
            push!(passed_pop, cl.tail == tail_index)
            push!(passed_pop, cl.length == len)
        end

        push!(passed_pop, cl.data == real_data)
        push!(passed_pop, cl.head == head_index)
        push!(passed_pop, cl.limit == mem)
    end
    @test all(passed_pop)
    @test length(cl) == mem - 15

    @test repr(cl) == "CircularQueue{Int64, mem:4/19}([25, 24, 23, 22, ])"

end
