using Test
using DataStructure101
const DS = DataStructure101

@testset "Union Find" begin
    n = 16
    set = DS.DisjointSet(n)
    @test set.parent == -ones(Int64, n)

    for i in 1:n
        @test DS.find(set, i) == i
    end

    union!(set, 1, 2)
    union!(set, 2, 3)
    union!(set, 3, 4)
    for i in 1:n
        if i in 2:4
            @test DS.find(set, i) == 1
        else
            @test DS.find(set, i) == i
        end
    end # for
end # testset
