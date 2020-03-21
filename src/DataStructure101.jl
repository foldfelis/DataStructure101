module DataStructure101

    filename = [
        "stack",
        "queue",
        "deque",
        "circularqueue",
        "sparsearray",
        "linkedlist",
        "binarytree",
        "unionfind",
        "heap",
        "minmaxheap",
        "priorityqueue",
        "adjacencymatrix",
        "adjacencylist",
    ]

    for f in filename
        fname = string(f, ".jl")
        include(fname)
    end

end  # module DataStructure101
