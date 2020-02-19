@testset "Heap" begin

    heap = Heap{Int64}(true)
    @test heap isa Heap
    for i=1:27
        push!(heap, i)
    end
    build!(heap)
    @test sort!(heap) == collect(27:-1:1)

    heap = Heap{Int64}(false)
    for i=30:-1:1
        push!(heap, i)
    end
    build!(heap)
    @test sort!(heap) == collect(1:30)
end
