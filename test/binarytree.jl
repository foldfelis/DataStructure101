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

    @test leftchild(tn) isa NullNode
    @test rightchild(tn) isa NullNode
    @test value(tn) == 1
    @test value(NullNode()) == nothing

end

@testset "Test BinaryTree" begin

    # Initial a Binary Tree with data '1'
    bt = BinaryTree{Int64}(1)
    passed_initial = [
        bt.root.value == 1,
        bt.length == 1,
    ]
    @test all(passed_initial)

    # Push Test: Push 2:25 value into tree
    passed_push = []
    for i=2:27
        push!(bt, i)
        push!(passed_push, bt[i].value == i)
    end
    @test all(passed_push)

    # Value Test: Get 10th value from tree
    @test value(bt, 10) == 10

    # Value Test: Get Left child of 10th value from tree
    @test leftchild(bt, 10) == 20

    # Value Test: Get Right child of 10th value from tree
    @test rightchild(bt, 10) == 21

    # Get Root
    @test String(root(bt)) == "1"

end