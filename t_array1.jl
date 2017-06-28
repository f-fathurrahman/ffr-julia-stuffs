# comment
# A = [0, 1, 3, 4]
# for i=1:4
#   @printf "A[%d] = %d\n" i A[i]
# end

#
# Fibonacci
#
A = Array{Int64}(15)
A[1] = 0
A[2] = 1
[ A[i] = A[i-1] + A[i-2] for i = 3:length(A) ]
#for i=3:length(A)
#  A[i] = A[i-1] + A[i-2]
#end

# Display
for i=1:length(A)
  @printf("%d ",A[i])
end
@printf("\n")

A = [1 2 3; 4 5 6];
