using Test
using DataStructure101
const DS = DataStructure101

@testset "Test TreeNode" begin

    # Initial a TreeNode with data '1'
    T_e = Int64
    tn = DS.TreeNode{T_e}(1)

    @test DS.value(tn) == 1
    @test DS.parent(tn) isa DS.NullNode
    @test DS.left_child(tn) isa DS.NullNode
    @test DS.right_child(tn) isa DS.NullNode
    @test DS.level(tn) == 0

    @test repr(tn) == "TreeNode{$T_e}(1)"
end

@testset "Test BinaryTree" begin

    # Initial a Binary Tree with data '1'
    bt = DS.BinaryTree(1)
    @test DS.value(DS.root(bt)) == 1
    @test length(bt) == 1
    @test repr(bt) == "BinaryTree(\n\nTreeNode(1)\n)"

    bt = DS.BinaryTree()
    @test DS.value(DS.root(bt)) == nothing
    @test length(bt) == 0
    @test repr(bt) == "BinaryTree(\n)"

    @test eltype(bt) == Int64

    # Set index Test: Push 1:27 value into tree
    for i=1:27
        bt[i] = i
        @test DS.value(bt[i]) == i
    end

    @test DS.parent(bt[100]) isa DS.NullNode
    @test DS.right_child(bt[100]) isa DS.NullNode
    @test DS.left_child(bt[100]) isa DS.NullNode
    @test DS.level(bt[25]) == 4

    @test repr(bt) == "BinaryTree(\n" *
        "\n\t\t\tTreeNode(15)\n" *
        "\n\t\tTreeNode(7)\n" *
        "\n\t\t\tTreeNode(14)\n" *
        "\n\tTreeNode(3)\n" *
        "\n\t\t\t\tTreeNode(27)\n" *
        "\n\t\t\tTreeNode(13)\n" *
        "\n\t\t\t\tTreeNode(26)\n" *
        "\n\t\tTreeNode(6)\n" *
        "\n\t\t\t\tTreeNode(25)\n" *
        "\n\t\t\tTreeNode(12)\n" *
        "\n\t\t\t\tTreeNode(24)\n" *
        "\nTreeNode(1)\n" *
        "\n\t\t\t\tTreeNode(23)\n" *
        "\n\t\t\tTreeNode(11)\n" *
        "\n\t\t\t\tTreeNode(22)\n" *
        "\n\t\tTreeNode(5)\n" *
        "\n\t\t\t\tTreeNode(21)\n" *
        "\n\t\t\tTreeNode(10)\n" *
        "\n\t\t\t\tTreeNode(20)\n" *
        "\n\tTreeNode(2)\n" *
        "\n\t\t\t\tTreeNode(19)\n" *
        "\n\t\t\tTreeNode(9)\n" *
        "\n\t\t\t\tTreeNode(18)\n" *
        "\n\t\tTreeNode(4)\n" *
        "\n\t\t\t\tTreeNode(17)\n" *
        "\n\t\t\tTreeNode(8)\n" *
        "\n\t\t\t\tTreeNode(16)\n" *
    ")"
end
