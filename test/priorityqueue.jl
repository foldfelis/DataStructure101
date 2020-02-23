@testset "Priority Queue" begin

    pq = PriorityQueue{Char}()
    for i = 1:26
        push!(pq, '`'+i)
    end
    @test firstpriority(pq) == 'a'
    @test lastpriority(pq) == 'z'
    @test popfirst!(pq) == 'a'
    @test pop!(pq) == 'z'
end