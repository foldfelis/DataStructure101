module DataStructure101

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
        fname = string(f, ".jl")
        include(fname)
    end

end  # module DataStructure101
