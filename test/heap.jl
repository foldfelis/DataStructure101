@testset "Heap" begin

    heap = MaxHeap{Int64}()
    @test heap isa Heap
    for i=1:27
        push!(heap, i)
    end
    build!(heap)
    @test sort!(heap) == collect(27:-1:1)

    heap = MinHeap{Int64}()
    for i=30:-1:1
        push!(heap, i)
    end
    build!(heap)
    @test sort!(heap) == collect(1:30)
end
