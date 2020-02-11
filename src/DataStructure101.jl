module DataStructure101
    import  Base: show, push!, pop!, pushfirst!, popfirst!, length,
     delete!, insert!, setindex!, getindex, String, size, eltype

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
    root

    filename = [
        "stack",
        "linkedlist",
        "queue",
        "circularqueue",
        "deque",
        "sparsearray",
        "binarytree",
    ]

    for f in filename
        fname = string(f, ".jl")
        include(fname)
    end

end  # module DataStructure101