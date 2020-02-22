module DataStructure101
    import  Base: show, push!, pop!, pushfirst!, popfirst!, length, union!,
     delete!, insert!, setindex!, getindex, String, size, eltype, sort!

    export

    # LinkedList
    AbstractNode,
    NullNode,
    Node,
    show,
    LinkedList,
    head,
    tail,
    length,
    movePtr,
    movePtr2head,
    movePtr2tail,
    push!,
    pushfirst!,
    insert!,
    delete!,

    # Queue
    Queue,
    pop!,

    # Stack
    Stack,

    # CircularDeque
    CircularQueue,

    # Deque
    Deque,
    popfirst!,

    # Sparse Array
    ValueEntry,
    SparseArray,
    setindex!,
    getindex,
    eltype,

    # BinaryTree
    TreeNode,
    String,
    BinaryTree,
    getindex,
    value,
    leftchild,
    rightchild,
    root,
    tree_repr,

    # UnionFind
    makeset,
    find,
    union!,

    # Heap
    Heap,
    MaxHeap,
    MinHeap,
    heapify!,
    build!,
    sort!

    # MinMaxHeap
#     MinMaxHeap

    filename = [
        "stack",
        "linkedlist",
        "queue",
        "circularqueue",
        "deque",
        "sparsearray",
        "binarytree",
        "unionfind",
        "heap",
#         "minmaxheap",
    ]

    for f in filename
        fname = string(f, ".jl")
        include(fname)
    end

end  # module DataStructure101