@testset "Heap" begin
    heap = Heap{Int64}()
    @test heap isa Heap

#     for i=2:27
#         push!(heapll, i)
#     end
#     @show heapll

#     @test value(root(heapll)) == 1
#
#     @test value(leftchild(heapll, 1)) == 2
#     @test value(rightchild(heapll, 1)) == 3


#     for i = 1:length(heapll)
#         @test value(heapll[i]) == i
#     end

#     swap!(heapll, 1, 27)
#     @show heapll
#
#     heapify!(heapll)
#     @show heapll
end
