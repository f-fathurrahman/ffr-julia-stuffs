sumsq(x,y) = x^2 + y^2

function estimate_pi(N::Int)
    cnt = 0
    for i=1:N
        if sumsq(rand(), rand()) < 1.0
            cnt = cnt + 1
        end
    end
    return 4.0*Float64(cnt)/Float64(N)
end

function testMain()
    for i = 1:9
        Ntrials = Int(10^i)
        @time pi_est = estimate_pi(Ntrials)
        @printf("10^%d %18.10f %18.10e\n", i, pi_est, abs(pi-pi_est))
    end
end

testMain()
