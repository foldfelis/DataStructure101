@testset "Union Find" begin

    n = 16
    set = makeset(n)
    @test set == -ones(Int64, n)
    
    passed_find = []
    for i in 1:n
        push!(passed_find, find(set, i) == i)
    end

    union!(set, 1, 2)
    union!(set, 2, 3)
    union!(set, 3, 4)
    for i in 1:n
        if i in 2:4 push!(passed_find, find(set, i) == 1)
        else push!(passed_find, find(set, i) == i) end
    end

    @test all(passed_find)
end