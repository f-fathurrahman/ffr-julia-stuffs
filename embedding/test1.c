#include <stdio.h>
#include <julia.h>

JULIA_DEFINE_FAST_TLS()
// only define this once, in an executable (not in a shared library) if you want fast code.

int main(int argc, char *argv[])
{
  // required: setup the Julia context
  jl_init();
  //jl_init__threading();

  // run Julia commands
  jl_eval_string("a = 4.0");
  jl_eval_string("println(sqrt(a))");
  jl_eval_string("str1 = \"This is a string defined in Julia\"");
  jl_eval_string("println(str1)");

  jl_eval_string("using PWDFT");
  jl_eval_string("println(rand(ComplexF64,4,4))");
  jl_eval_string("atoms = init_atoms_xyz_string(\"1\n\nH  0.0  0.0  0.0\")");
  jl_eval_string("println(atoms)");

  jl_eval_string("using LinearAlgebra");
  jl_eval_string("println(inv(rand(3,3)))");

  // strongly recommended: notify Julia that the
  // program is about to terminate. this allows
  // Julia time to cleanup pending write requests
  // and run all finalizers
  jl_atexit_hook(0);

  printf("Program ended normally\n");

  return 0;
}

