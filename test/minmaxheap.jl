@testset "Min Max Heap" begin

    heap = MinMaxHeap{Int64}()
    @test heap isa MinMaxHeap
    @test heap isa Heap

    for i=30:-1:1
        push!(heap, i)
    end
    build!(heap)

    @test maximum(heap) == 30
    @test minimum(heap) == 1

    @test popmax!(heap) == 30
    @test popmin!(heap) == 1

    pushbubble!(heap, 1)
    @test minimum(heap) == 1

    pushbubble!(heap, 30)
    @test maximum(heap) == 30

    @test sort!(heap) == collect(1:30)
end
