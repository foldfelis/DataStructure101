module DataStructure101
    import  Base: show, push!, pop!, pushfirst!, popfirst!, length,
     delete!, insert!

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
    popfirst!

    filename = [
        "stack",
        "linkedlist",
        "queue",
        "circularqueue",
        "deque",
    ]

    for f in filename
        fname = string(f, ".jl")
        include(fname)
    end

end  # module DataStructure101
