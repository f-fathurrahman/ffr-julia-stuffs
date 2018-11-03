function f(iter)
    next = iterate(iter)
    while next !== nothing
       (i, state) = next
       next = iterate(iter, state)
    end
end

@time f(1:1_000_000)
@time f(1:1_000_000)
