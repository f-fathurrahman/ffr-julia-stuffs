"Sieve of Erasthosthenes function docstring"
function es(n::Int)
    isprime = ones(Bool,n)
    isprime[1] = false # 1 is not prime
    for i in 2:round(Int,sqrt(n))
        if isprime[i]
            for j in (i*i):i:n
                isprime[j] = false
            end # for
        end # if
    end # for
    return filter( x -> isprime[x], 1:n)
end # function


println(es(10))
