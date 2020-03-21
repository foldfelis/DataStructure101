@testset "Priority Queue" begin

    pq = PriorityQueue{Char}()
    for i = 1:26
        push!(pq, '`'+i)
    end
    @test minimum(pq) == (1 => 'a')
    @test maximum(pq) == (26 => 'z')
    @test pop_min!(pq) == 'a'
    @test pop_max!(pq) == 'z'
    update!(pq, 24, -5)
    @test pq.data[end-5] == 'y'
    update!(pq, 1, 5)
    @test pq.data[6] == 'b'
end
