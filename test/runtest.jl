using DataStructure101
using Test

filename = [
    "stack",
    "linkedlist",
    "queue",
]

for f in filename
    fname = string(f, ".jl")
    include(fname)
end
