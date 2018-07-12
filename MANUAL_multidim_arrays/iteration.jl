#=
The manual says:

    The recommended ways to iterate over the whole array are
    ```
    for a in A
        # do sth
    end

    for i in eachindex(A)
        # do sth
    end
    ```

Result for my Pentium laptop:
  138.716 ms (6 allocations: 61.04 MiB)
  139.953 ms (6 allocations: 61.04 MiB)
  139.771 ms (6 allocations: 61.04 MiB)

```
julia> versioninfo()
Julia Version 0.7.0-beta.0
Commit f41b1ecaec (2018-06-24 01:32 UTC)
Platform Info:
  OS: Linux (x86_64-pc-linux-gnu)
  CPU: Intel(R) Pentium(R) CPU B980 @ 2.40GHz
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-6.0.0 (ORCJIT, sandybridge)
```

=#

using Random
using BenchmarkTools

const N1 = 1000
const N2 = 2000

function using_eachindex()
    srand(1234)
    A = rand(ComplexF64,N1,N2)
    B = rand(ComplexF64,N1,N2)
    sum = 0.0 + 0.0*im
    for i in eachindex(A)
        sum = sum + A[i]*B[i]
    end
end

function using_usual_for()
    srand(1234)
    A = rand(ComplexF64,N1,N2)
    B = rand(ComplexF64,N1,N2)
    sum = 0.0 + 0.0*im
    for j = 1:size(A,2)
        for i = 1:size(A,1)
            sum = sum + A[i,j]*B[i,j]
        end
    end
end

# Reversed index in the loop
function using_bad_usual_for()
    srand(1234)
    A = rand(ComplexF64,N1,N2)
    B = rand(ComplexF64,N1,N2)
    sum = 0.0 + 0.0*im
    for i = 1:size(A,1)
        for j = 1:size(A,2)
            sum = sum + A[i,j]*B[i,j]
        end
    end
end

@btime using_eachindex()
@btime using_usual_for()
@btime using_bad_usual_for()

