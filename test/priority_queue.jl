using Test
using DataStructure101
const DS = DataStructure101

@testset "Priority Queue" begin
    pq = DS.PriorityQueue{Char}()
    for i = 1:26
        push!(pq, '`'+i)
    end
    @test repr(pq) == "PriorityQueue{Char}([" *
        "'a', 'b', 'c', 'd', 'e', 'f', 'g', " *
        "'h', 'i', 'j', 'k', 'l', 'm', 'n', " *
        "'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']"
    @test minimum(pq) == (1 => 'a')
    @test maximum(pq) == (26 => 'z')
    @test DS.pop_min!(pq) == 'a'
    @test DS.pop_max!(pq) == 'z'
    DS.update!(pq, 24, -5)
    @test pq.data[end-5] == 'y'
    DS.update!(pq, 1, 5)
    @test pq.data[6] == 'b'
end
