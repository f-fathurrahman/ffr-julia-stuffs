#include <stdio.h>

int simple( int N, int *Ns, double *data )
{
  printf("N = %d\n", N);
  int i;
  for( i = 0; i < 3; i++ ) {
    printf("i = %d, Ns = %d\n", i, Ns[i]);
  }

  // Modify Ns
  Ns[2] = 44;

  for( i = 0; i < N; i++ ) {
    printf("%d %f\n", i, data[i]);
  }

  // Modify data
  data[4] = 1.2345;

  return 123;
}

