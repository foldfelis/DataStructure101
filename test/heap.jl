using Test
using DataStructure101
const DS = DataStructure101

@testset "Heap" begin
    heap = DS.MaxHeap()
    @test heap isa DS.Heap
    for i=1:27
        push!(heap, i)
    end
    DS.build!(heap)
    @test sort!(heap) == collect(27:-1:1)

    heap = DS.MinHeap()
    for i=30:-1:1
        push!(heap, i)
    end
    DS.build!(heap)

    @test length(heap) == 30
    @test DS.level(heap, 5) == 3
    @test DS.root(heap) == 1
    @test DS.left_child(heap, 5) == 10
    @test DS.right_child(heap, 5) == 11

    @test repr(heap) == "Heap(\n" *
        "\n\t\t\tHeapNode(16)\n" *
        "\t\t\t\tHeapNode(24)\n" *
        "\t\tHeapNode(3)\n" *
        "\t\t\t\tHeapNode(30)\n" *
        "\t\t\tHeapNode(17)\n" *
        "\t\t\t\tHeapNode(28)\n" *
        "\tHeapNode(2)\n" *
        "\t\t\t\tHeapNode(18)\n" *
        "\t\t\tHeapNode(5)\n" *
        "\t\t\t\tHeapNode(25)\n" *
        "\t\tHeapNode(4)\n" *
        "\t\t\t\tHeapNode(19)\n" *
        "\t\t\tHeapNode(6)\n" *
        "\t\t\t\tHeapNode(7)\n" *
        "HeapNode(1)\n" *
        "\t\t\t\tHeapNode(29)\n" *
        "\t\t\tHeapNode(20)\n" *
        "\t\t\t\tHeapNode(26)\n" *
        "\t\tHeapNode(9)\n" *
        "\t\t\t\tHeapNode(21)\n" *
        "\t\t\tHeapNode(10)\n" *
        "\t\t\t\tHeapNode(11)\n" *
        "\tHeapNode(8)\n" *
        "\t\t\t\tHeapNode(22)\n" *
        "\t\t\tHeapNode(13)\n" *
        "\t\t\t\tHeapNode(27)\n" *
        "\t\tHeapNode(12)\n" *
        "\t\t\t\tHeapNode(23)\n" *
        "\t\t\tHeapNode(14)\n" *
        "\t\t\t\tHeapNode(15)\n" *
    ")"

    @test sort!(heap) == collect(1:30)
end
