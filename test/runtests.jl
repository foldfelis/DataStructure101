using DataStructure101
using Test

filename = [
    "linkedlist",
    "stack",
    "queue",
]

for f in filename
    @info "\n
        ###########\n
        Test '$(f)'\n
        ###########\n"
        
    fname = string(f, ".jl")
    include(fname)
end
