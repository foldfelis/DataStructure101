using Test
using DataStructure101
const DS = DataStructure101

@testset "Test LinkedList" begin
    # Initial a LinkedList
    T_e = Int64
    T = DS.LinkedList{T_e}
    ll = T()

    @test length(ll) == 0
    @test repr(ll) == "LinkedList{$T_e}([])"

    for i=1:5
        push!(ll, i)
        @test ll[i] == i
    end

    @test repr(ll) == "LinkedList{$T_e}([1, 2, 3, 4, 5])"

    for i=1:5
        @test popfirst!(ll) == i
    end

    @test repr(ll) == "LinkedList{$T_e}([])"

    for i=6:10
        pushfirst!(ll, i)
        @test ll[1] == i
    end

    @test repr(ll) == "LinkedList{$T_e}([10, 9, 8, 7, 6])"

    for i=6:10
        @test pop!(ll) == i
    end

    @test repr(ll) == "LinkedList{$T_e}([])"

    # Setindex Test
    push!(ll, 1)
    ll[1] = 10
    @test ll[1] == 10
    @test repr(ll) == "LinkedList{$T_e}([10])"

    # Insert Test

end
