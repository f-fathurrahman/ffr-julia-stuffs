function f(iter)
    state = start(iter)
    i = 0
    while !(done(iter, state)) & (i < 1_000_000)
       i += 1
       v, state = next(iter, state)
    end
end

@time f(zeros(1_000_000))
@time f(zeros(1_000_000))
