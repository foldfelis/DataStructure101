file_name = [
    # "stack",
    # "queue",
    # "deque",
    "circular_queue",
    # "sparse_array",
    # "linked_list",
    # "binary_tree",
    # "union_find",
    # "heap",
    # "min_max_heap",
    # "priority_queue",
    # "adjacency_matrix",
    # "adjacency_list",
]

for f in file_name
    teststr = "# Test '$(f)' #"
    len = length(teststr)
    teststr = "\n$("#"^len)\n$(teststr)\n$("#"^len)\n"
    println()
    @info teststr

    fname = string(f, ".jl")
    include(fname)
end
