using Test
using DataStructure101
const DS = DataStructure101

@testset "Test Nodes" begin
    node = DS.NullNode()
    @test repr(node) == ""

    node = DS.ListNode{Int64}(10)
    @test repr(node) == "10"
end

@testset "Test LinkedList" begin
    # Initial a LinkedList
    T_e = Int64
    T = DS.LinkedList{T_e}
    ll = T()
    @test length(ll) == 0
    @test repr(ll) == "LinkedList{$T_e}([])"

    # Push Test
    for i=1:5
        push!(ll, i)
        @test ll[i] == i
    end
    @test repr(ll) == "LinkedList{$T_e}([1, 2, 3, 4, 5])"

    # Popfirst Test
    for i=1:5
        @test popfirst!(ll) == i
    end
    @test repr(ll) == "LinkedList{$T_e}([])"

    # Pushfirst Test
    for i=6:10
        pushfirst!(ll, i)
        @test ll[1] == i
    end
    @test repr(ll) == "LinkedList{$T_e}([10, 9, 8, 7, 6])"

    # Pop Test
    for i=6:10
        @test pop!(ll) == i
    end
    @test repr(ll) == "LinkedList{$T_e}([])"

    # Setindex Test
    push!(ll, 1)
    ll[1] = 30
    @test ll[1] == 30
    @test repr(ll) == "LinkedList{$T_e}([30])"

    # Insert Test
    ll = T()
    insert!(ll, 30, 1)
    @test ll[1] == 30
    @test repr(ll) == "LinkedList{$T_e}([30])"

    insert!(ll, 10, 1)
    @test ll[1] == 10
    @test repr(ll) == "LinkedList{$T_e}([10, 30])"

    insert!(ll, 20, 2)
    @test ll[2] == 20
    @test repr(ll) == "LinkedList{$T_e}([10, 20, 30])"

    insert!(ll, 40, 4)
    @test ll[4] == 40
    @test repr(ll) == "LinkedList{$T_e}([10, 20, 30, 40])"

    # Delete Test
    @test delete!(ll, 1) == 10
    @test repr(ll) == "LinkedList{$T_e}([20, 30, 40])"

    @test delete!(ll, 2) == 30
    @test repr(ll) == "LinkedList{$T_e}([20, 40])"

    @test delete!(ll, 2) == 40
    @test repr(ll) == "LinkedList{$T_e}([20])"

    @test delete!(ll, 1) == 20
    @test repr(ll) == "LinkedList{$T_e}([])"
end
