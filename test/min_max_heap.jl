using Test
using DataStructure101
const DS = DataStructure101

@testset "Min Max Heap" begin
    heap = DS.MinMaxHeap()
    @test heap isa DS.MinMaxHeap
    @test heap isa DS.Heap

    for i=30:-1:1
        push!(heap, i)
    end
    DS.build!(heap)

    @test maximum(heap) == 30
    @test minimum(heap) == 1

    @test DS.pop_max!(heap) == 30
    @test DS.pop_min!(heap) == 1

    DS.push_bubble!(heap, 1)
    @test minimum(heap) == 1

    DS.push_bubble!(heap, 30)
    @test maximum(heap) == 30

    @test sort!(heap) == collect(1:30)
end
