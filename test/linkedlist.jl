#############
# Node Test #
#############
@info "Initial a Node with data '0'"
T = Node{Int64}
node = T(0)
println("Show: $(node)\n")
@info "Node type test: " @test node isa T
println()

####################
# Linked List Test #
####################
@info "Initial a Linked List with data '0'"
T = LinkedList{Int64}
ll = T(0)
println("Show: $(ll)\n")
@info "Linked List type test: " @test ll isa T
println()

@info "Push test: Push data into LinkedList 20 times by 1:20"
for i=1:20
    push!(ll, i)
end
println("Show: $(ll)\n")

@info "Push test: Push data into the middle of LinkedList"
movePtr(ll, -5)
println(ll)
push!(ll, 100)
println(ll, "\n")

@info "Delete Current Node Test"
movePtr(ll, 3)
println(ll)
current_data = delete!(ll)
println("Deleted data: $(current_data)")
println(ll, "\n")

@info "Move 2 head Test"
movePtr2head(ll)
println("Show: $(ll)\n")

@info "Move 2 tail Test"
movePtr2tail(ll)
println("Show: $(ll)\n")

@info "Pushfirst Test"
pushfirst!(ll, 123)
println("Show: $(ll)\n")

@info "Insert Test: Insert '5987' to index=5"
insert!(ll, 5987, 5)
println("Show: $(ll)\n")

@info "Insert Test: Insert '8745' to index=-5"
insert!(ll, 8745, -5)
println("Show: $(ll)\n")

@info "Insert Test: Insert '1010' to index=0"
insert!(ll, 1010, 0)
println("Show: $(ll)\n")

@info "Insert Test: Insert '1111' to index=1"
insert!(ll, 1111, 1)
println("Show: $(ll)\n")

@info "Insert Test: Insert '-1111' to index=-1"
insert!(ll, -1111, -1)
println("Show: $(ll)\n")

@info "Delete Test: Delete data from index=0"
delete_data = delete!(ll, 0)
println("Delete data: $(delete_data)")
println("Show: $(ll)\n")

@info "Delete Test: Delete data from index=1"
delete_data = delete!(ll, 1)
println("Delete data: $(delete_data)")
println("Show: $(ll)\n")

@info "Delete Test: Delete data from index=-1"
delete_data = delete!(ll, -1)
println("Delete data: $(delete_data)")
println("Show: $(ll)\n")
