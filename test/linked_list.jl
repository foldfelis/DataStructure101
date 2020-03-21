@testset "Test Node" begin

    # Initial a Node with data '0'
    T_e = Int64
    T = Node{T_e}
    node = T(0)
    @test node.data == 0

    # Node type test:
    @test node isa T

end

@testset "Test LinkedList" begin

    # Initial a Linked List with data '1'
    T_e = Int64
    T = LinkedList{T_e}
    value = 1
    ll = T(value)
    @test ll.current_node.data == value

    # Linked List type test:
    @test ll isa T

    # Push test: Push data into LinkedList 20 times by 2:20
    passed_push = []
    len = 20
    for i=2:len
        push!(ll, i)
        push!(passed_push, ll.current_node.data == i)
    end
    @test all(passed_push)

    # Move Test
    passed_move = []
    movePtr(ll, -5)
    value = len - 5
    push!(passed_move, ll.current_node.data == value)
    movePtr(ll, 3)
    value +=  3
    push!(passed_move, ll.current_node.data == value)
    @test all(passed_move)

    # Push test: Push data into the middle of LinkedList
    push!(ll, 100)
    passed_push_middle = [
        ll.current_node.prev.data == value,
        ll.current_node.data == 100,
        ll.current_node.next.data == value + 1,
    ]
    @test all(passed_push_middle)

    # Delete Current Node Test
    deleted_data = delete!(ll)
    passed_delete = [
        deleted_data == 100,
        ll.current_node.prev.data == value,
        ll.current_node.data == value + 1,
        ll.current_node.next.data == value + 2,
    ]
    @test all(passed_delete)

    # Move 2 head Test
    movePtr2head(ll)
    @test ll.current_node.data == 1

    # Move 2 tail Test
    movePtr2tail(ll)
    @test ll.current_node.data == len

    # Pushfirst Test
    value = 123
    pushfirst!(ll, value)
    passed_pushfirst = [
        ll.current_node.prev isa NullNode,
        ll.current_node.data == value,
        ll.current_node.next.data == 1,
    ]
    @test all(passed_pushfirst)

    # Delete first Node Test
    deleted_data = delete!(ll, 1)
    passed_deletefirst = [
        deleted_data == value,
        ll.current_node.prev isa NullNode,
        ll.current_node.data == 1,
        ll.current_node.next.data == 2,
    ]
    @test all(passed_deletefirst)

    passed_insert = []
    # Insert Test: Insert '5987' to index=5
    value = 5987
    index = 5
    insert!(ll, value, index)
    push!(passed_insert, ll.current_node.prev.data == index - 1)
    push!(passed_insert, ll.current_node.data == value)
    push!(passed_insert, ll.current_node.next.data == index)
    delete!(ll)

    # Insert Test: Insert '8745' to index=-5
    value = 8745
    index = -5
    insert!(ll, value, index)
    push!(passed_insert, ll.current_node.prev.data == len+index + 1)
    push!(passed_insert, ll.current_node.data == value)
    push!(passed_insert, ll.current_node.next.data == len+index + 2)
    delete!(ll)

    # Insert Test: Insert '1010' to index=0
    value = 1010
    index = 1
    insert!(ll, value, 0)
    push!(passed_insert, ll.current_node.prev isa NullNode)
    push!(passed_insert, ll.current_node.data == value)
    push!(passed_insert, ll.current_node.next.data == index)
    delete!(ll)

    # Insert Test: Insert '1111' to index=1
    value = 1111
    index = 1
    insert!(ll, value, 1)
    push!(passed_insert, ll.current_node.prev isa NullNode)
    push!(passed_insert, ll.current_node.data == value)
    push!(passed_insert, ll.current_node.next.data == index)
    delete!(ll)

    # Insert Test: Insert '-1111' to index=-1
    value = -1111
    index = len
    insert!(ll, value, -1)
    push!(passed_insert, ll.current_node.prev.data == index)
    push!(passed_insert, ll.current_node.data == value)
    push!(passed_insert, ll.current_node.next isa NullNode)
    delete!(ll)

    @test all(passed_insert)

    passed_deleted = []
    index = 1
    # Delete Test: Delete data from index=0
    deleted_data = delete!(ll, 0)
    push!(passed_deleted, deleted_data == index)
    push!(passed_deleted, ll.current_node.prev isa NullNode)
    push!(passed_deleted, ll.current_node.data == index + 1)
    push!(passed_deleted, ll.current_node.next.data == index + 2)

    index += 1
    # Delete Test: Delete data from index=1
    deleted_data = delete!(ll, 1)
    push!(passed_deleted, deleted_data == index)
    push!(passed_deleted, ll.current_node.prev isa NullNode)
    push!(passed_deleted, ll.current_node.data == index + 1)
    push!(passed_deleted, ll.current_node.next.data == index + 2)

    index = len
    # Delete Test: Delete data from index=-1"
    deleted_data = delete!(ll, -1)
    push!(passed_deleted, deleted_data == index)
    push!(passed_deleted, ll.current_node.prev.data == index - 2)
    push!(passed_deleted, ll.current_node.data == index - 1)
    push!(passed_deleted, ll.current_node.next isa NullNode)

    @test all(passed_deleted)

end