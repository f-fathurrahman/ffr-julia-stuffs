using Random
using MPI
using PencilFFTs

MPI.Init()
my_rank = MPI.Comm_rank(MPI.COMM_WORLD)

dims = (16, 16, 16)  # input data dimensions
#transform = Transforms.RFFT()  # apply a 3D real-to-complex FFT
transform = Transforms.FFT()  # apply a 3D complex-to-complex FFT

# Distribute 12 processes on a 3 × 4 grid.
comm = MPI.COMM_WORLD  # we assume MPI.Comm_size(comm) == 12
proc_dims = (2, 2)

# Create plan
plan = PencilFFTPlan(dims, transform, proc_dims, comm)

# Allocate and initialise input data, and apply transform.
u = allocate_input(plan)
if my_rank == 0
    println(typeof(u))
end
rand!(u)
uF = plan * u

# Apply backwards transform. Note that the result is normalised.
v = plan \ uF
@assert u ≈ v

if my_rank == 0
    println("Pass here ...")
end
