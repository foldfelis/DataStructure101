@testset "Test TreeNode" begin

    # Initial a TreeNode with data '1'
    tn = TreeNode{Int64}(1, 1)

    passed_node = [
        tn.value == 1,
        tn.index == 1,
        tn.parent isa NullNode,
        tn.left isa NullNode,
        tn.right isa NullNode,
    ]
    @test all(passed_node)

    @test left_child(tn) isa NullNode
    @test right_child(tn) isa NullNode
    @test value(tn) == 1
    @test value(NullNode()) == nothing

    @test repr(tn) ==
        "TreeNode{Int64}( index=1\n Current node is root\n \tNode(1)\n \t\tNull\n \t\tNull\n)"
end

@testset "Test BinaryTree" begin

    # Initial a Binary Tree with data '1'
    bt = BinaryTree{Int64}(1)
    passed_initial = [
        bt.root.value == 1,
        bt.length == 1,
    ]
    @test all(passed_initial)

    @test eltype(bt) == Int64

    # Push Test: Push 2:25 value into tree
    passed_push = []
    for i=2:27
        push!(bt, i)
        push!(passed_push, bt[i].value == i)
    end
    @test all(passed_push)

    @test level(bt[10]) == 4

    # Value Test: Get 10th value from tree
    @test value(bt, 10) == 10

    # Value Test: Get Left child of 10th value from tree
    @test value(left_child(bt, 10)) == 20

    # Value Test: Get Right child of 10th value from tree
    @test value(right_child(bt, 10)) == 21

    # Get Root
    @test String(root(bt)) == "1"

    @test repr(bt) == "BinaryTree{Int64}("*
        "\n\n\t\t\tTreeNode(15)"*
        "\n\t\tTreeNode(7)"*
        "\n\t\t\tTreeNode(14)"*
        "\n\tTreeNode(3)"*
        "\n\t\t\t\tTreeNode(27)"*
        "\n\t\t\tTreeNode(13)"*
        "\n\t\t\t\tTreeNode(26)"*
        "\n\t\tTreeNode(6)"*
        "\n\t\t\t\tTreeNode(25)"*
        "\n\t\t\tTreeNode(12)"*
        "\n\t\t\t\tTreeNode(24)"*
        "\nTreeNode(1)"*
        "\n\t\t\t\tTreeNode(23)"*
        "\n\t\t\tTreeNode(11)"*
        "\n\t\t\t\tTreeNode(22)"*
        "\n\t\tTreeNode(5)"*
        "\n\t\t\t\tTreeNode(21)"*
        "\n\t\t\tTreeNode(10)"*
        "\n\t\t\t\tTreeNode(20)"*
        "\n\tTreeNode(2)"*
        "\n\t\t\t\tTreeNode(19)"*
        "\n\t\t\tTreeNode(9)"*
        "\n\t\t\t\tTreeNode(18)"*
        "\n\t\tTreeNode(4)"*
        "\n\t\t\t\tTreeNode(17)"*
        "\n\t\t\tTreeNode(8)"*
        "\n\t\t\t\tTreeNode(16)"*
    "\n)\n"

end
