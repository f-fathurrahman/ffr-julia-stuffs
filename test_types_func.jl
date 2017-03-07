function t1(n)
  s = 0
  for i in 1:n
    s += s/i
  end
end

function t2(n)
  s = 0.0
  for i in 1:n
    s += s/i
  end
end

@time t1(10000000)

@time t2(10000000)
