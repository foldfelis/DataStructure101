module DataStructure101

    file_name = [
        "stack",
        "queue",
        "deque",
        "circular_queue",
        "sparse_array",
        "linked_list",
        "binary_tree",
        "union_find",
        "heap",
        "min_max_heap",
        "priority_queue",
        "graph",
    ]

    for f in file_name
        include("$f.jl")
    end

end  # module DataStructure101
