@testset "Min Max Heap" begin

    heap = MinMaxHeap{Int64}()
    @test heap isa MinMaxHeap
    @test heap isa Heap

    for i=1:30
        push!(heap, i)
    end
    build!(heap)

end