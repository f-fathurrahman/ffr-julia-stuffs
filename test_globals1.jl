#I just finished studying Julia (and most importantly the performance tips!).
#I realized that the use of global vars makes the code slower. The counter-measure
#to that was to pass as many variables as possible to arguments of functions.
#Therefore I did the following test:

const x = 10.5  #these are globals
const y = 10.5

function bench1()  #acts on global
  z = 0.0
  for i in 1:100
    z += x^y
  end
  return z
end

function bench2(x, y)
  z = 0.0
  for i in 1:100
    z += x^y
  end
  return z
end

function bench3(x::Float64, y::Float64) #acts on arguments
  z::Float64 = 0.0
  for i in 1:100
    z += x^y
  end
  return z
end

@time [bench1() for j in 1:10000]
@time [bench2(x,y) for j in 1:10000]
@time [bench3(x,y) for j in 1:10000]

#I have to admit that the results were extremely unexpected, and they are not
#in agreement with what I have read. Results:
#
#0.001623 seconds (20.00 k allocations: 313.375 KB)
#0.003628 seconds (2.00 k allocations: 96.371 KB)
#0.002633 seconds (252 allocations: 10.469 KB)
# The average results are that the first function, which acts on global
# variables directly is always faster by about a factor of 2, than the last
# function which has all the proper declarations AND does not act directly
# on global variables. Can someone explain to me why?
