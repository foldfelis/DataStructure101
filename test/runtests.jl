using DataStructure101
using Test

filename = [
    "linkedlist",
    "stack",
    "queue",
    "circularqueue",
    "deque",
    "sparsearray",
    "binarytree",
    "unionfind",
    "heap",
    "minmaxheap",
    "priorityqueue",
    "adjacencymatrix",
    "adjacencylist",
]

for f in filename
    teststr = "# Test '$(f)' #"
    len = length(teststr)
    teststr = "\n$("#"^len)\n$(teststr)\n$("#"^len)\n"
    println()
    @info teststr

    fname = string(f, ".jl")
    include(fname)
end
