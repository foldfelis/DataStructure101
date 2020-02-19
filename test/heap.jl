@testset "Heap" begin

    heap = Heap{Int64}(true)
    @test heap isa Heap

    for i=1:27
        push!(heap, i)
    end
    @show heap

end
