using Random
using BenchmarkTools

function init_random_psik(Nkpt, Ngw, Nstates)
    srand(1234)
    psik = Array{Array{ComplexF64,2}}(undef,Nkpt)
    for ik = 1:Nkpt
        psik[ik] = rand(ComplexF64,Ngw[ik],Nstates)
    end
    return psik
end

function using_eachindex()
    Nkpt = 4
    Ngw = [300, 400, 300, 400]
    Nstates = 5
    psik = init_random_psik(Nkpt, Ngw, Nstates)
    alpha = 0.5
    for ik in eachindex(psik)
        for ist in eachindex(psik[ik][1,:])
            for ig in eachindex(psik[ik][:,1])
                psik[ik][ig,ist] = alpha*psik[ik][ig,ist]
            end
        end
    end
end


function using_eachindex_v2()
    Nkpt = 4
    Ngw = [300, 400, 300, 400]
    Nstates = 5
    psik = init_random_psik(Nkpt, Ngw, Nstates)
    alpha = 0.5
    for psi in psik
        for ist in eachindex(psi[1,:])
            for ig in eachindex(psi[:,1])
                psi[ig,ist] = alpha*psi[ig,ist]
            end
        end
    end
end


function using_3d_array()
    Nkpt = 4
    Ngw = [300, 400, 300, 400]
    Nstates = 5
    #
    Ngwx = maximum(Ngw)
    #
    srand(1234)
    psik = rand(ComplexF64, Ngwx, Nstates, Nkpt)
    alpha = 0.5
    for ik = 1:Nkpt
        for ist = 1:Nstates
            for ig = 1:Ngw[ik]
                psik[ig,ist,ik] = alpha*psik[ig,ist,ik]
            end
        end
    end
end


function using_3d_array_eachindex()
    Nkpt = 4
    Ngw = [300, 400, 300, 400]
    Nstates = 5
    #
    Ngwx = maximum(Ngw)
    #
    srand(1234)
    psik = rand(ComplexF64, Ngwx, Nstates, Nkpt)
    alpha = 0.5
    for ik in eachindex(psik[1,1,:])
        for ist in eachindex(psik[1,:,1])
            for ig = 1:Ngw[ik]
                psik[ig,ist,ik] = alpha*psik[ig,ist,ik]
            end
        end
    end
end

println("\nusing_eachindex:")
@btime using_eachindex()

println("\nusing_3d_array:")
@btime using_3d_array()

println("\nusing_eachindex_v2:")
@btime using_eachindex_v2()

println("\nusing_3d_array_eachindex:")
@btime using_3d_array_eachindex()

