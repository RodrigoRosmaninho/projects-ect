//
// António Rui Borges
//
// ACA 2020/2021
//
// Reference implementation
//

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#include "common.h"
#include <cuda_runtime.h>

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// program configuration
//

#ifndef N
# define N  (1 << 16)
#endif

static void cyclicCircConv_cpu_kernel (float *x, float *y, float *xy, unsigned int nSamp);
__global__ static void cyclicCircConv_cuda_kernel (float *x, float *y, float *xy, unsigned int nSamp);
static double get_delta_time(void);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Main program
//

int main (int argc, char **argv)
{
  printf("%s Starting...\n", argv[0]);

  // set up device
  int dev = 0;
  int i;

  cudaDeviceProp deviceProp;
  CHECK (cudaGetDeviceProperties (&deviceProp, dev));
  printf("Using Device %d: %s\n", dev, deviceProp.name);
  CHECK (cudaSetDevice (dev));

  // create memory areas in host and device memory where the signals and their ccyclic circular convolution will be stored
  float *host_x, *host_y, *host_xy;

  host_x = (float *) malloc (N * sizeof (float));
  host_y = (float *) malloc (N * sizeof (float));
  host_xy = (float *) malloc (N * sizeof (float));

  // initialize signal datacyclicCircConv_cuda_kernel
  (void) get_delta_time ();
  srand(0xACA2020);
  for (i = 0; i < N; i++)
  { host_x[i] = (float) ((double) rand () / RAND_MAX - 0.5);
    host_y[i] = (float) ((double) rand () / RAND_MAX - 0.5);
  }
  printf ("The initialization of host data took %.3e seconds\n",get_delta_time ());

  // create memory areas in device memory and copy the host data to the device memory
  float *device_x, *device_y, *device_xy;;

  (void) get_delta_time ();
  CHECK (cudaMalloc ((void **) &device_x, N * sizeof (float)));
  CHECK (cudaMalloc ((void **) &device_y, N * sizeof (float)));
  CHECK (cudaMalloc ((void **) &device_xy, N * sizeof (float)));
  CHECK (cudaMemcpy (device_x, host_x, N * sizeof (float), cudaMemcpyHostToDevice));
  CHECK (cudaMemcpy (device_y, host_y, N * sizeof (float), cudaMemcpyHostToDevice));
  printf ("The creation and transfer of %ld bytes from the host to the device took %.3e seconds\n",
          (long) N * sizeof (float), get_delta_time ());

  // run the computational kernel in the GPU
  // as an example, N thread blocks are launched where each thread block deals solely with one convolution point
  unsigned int gridDimX, gridDimY, gridDimZ, blockDimX, blockDimY, blockDimZ;

  blockDimX = 1 << 8;                                                    // optimize!
  blockDimY = 1 << 0;                                                    // optimize!
  blockDimZ = 1 << 0;                                                    // optimize!
  gridDimX = 1 << 8;                                                     // optimize!
  gridDimY = 1 << 0;                                                     // optimize!
  gridDimZ = 1 << 0;                                                     // optimize!
  if ((blockDimX * blockDimY * blockDimZ * gridDimX * gridDimY * gridDimZ) != N)
     { fprintf (stderr,"Wrong launch configuration!\n");
       exit (1);
     }

  dim3 grid (gridDimX, gridDimY, gridDimZ);
  dim3 block (blockDimX, blockDimY, blockDimZ);

  (void) get_delta_time ();
  cyclicCircConv_cuda_kernel <<<grid, block>>> (device_x, device_y, device_xy, (unsigned int) N);
  CHECK (cudaDeviceSynchronize ());                            // wait for kernel to finish
  CHECK (cudaGetLastError ());                                 // check for kernel errors
  printf("The CUDA kernel <<<(%d,%d,%d), (%d,%d,%d)>>> took %.3e seconds to run\n",
         gridDimX, gridDimY, gridDimZ, blockDimX, blockDimY, blockDimZ, get_delta_time ());

  // copy kernel result back to host side
  float *modified_device_xy;

  modified_device_xy = (float *) malloc (N * sizeof (float));
  CHECK (cudaMemcpy (modified_device_xy, device_xy, N * sizeof (float), cudaMemcpyDeviceToHost));
  printf ("The transfer of %ld bytes from the device to the host took %.3e seconds\n",
          (long) N * sizeof (float), get_delta_time ());

  // free device global memory
  CHECK (cudaFree (device_x));
  CHECK (cudaFree (device_y));
  CHECK (cudaFree (device_xy));

  // reset device
  CHECK (cudaDeviceReset ());

  // run the computational kernel in the CPU
  (void) get_delta_time ();
  cyclicCircConv_cpu_kernel (host_x, host_y, host_xy, (unsigned int) N);
  printf("The cpu kernel took %.3e seconds to run (single core)\n", get_delta_time ());

  // compare
  for(i = 0; i < N; i++)
    if ((fabsf (host_xy[i]) < 1e-3) && (fabsf (modified_device_xy[i]) > 1.01e-3))
       { printf ("Mismatch in sample point %d: cpu %.3e - gpu %.3e\n", i, host_xy[i], modified_device_xy[i]);
         exit(1);
       }
       else if (fabsf ((host_xy[i] - modified_device_xy[i]) / host_xy[i]) >= 5e-2)
       { printf ("Mismatch in sample point %d: cpu %.3e - gpu %.3e\n", i, host_xy[i], modified_device_xy[i]);
         exit(1);
       }
  printf ("All is well!\n");

  // free host memory
  free (host_x);
  free (host_y);
  free (host_xy);
  free (modified_device_xy);

  return 0;
}

static void cyclicCircConv_cpu_kernel (float *x, float *y, float *xy, unsigned int nSamp)
{
  unsigned int i, k;
  float tmp;

  for (i = 0; i < nSamp; i++)
  { tmp = 0.0;
    for (k = 0; k < nSamp; k++)
      tmp += x[k] * y[(i + k) % nSamp];
    xy[i] += tmp;
  }
}

__global__ static void cyclicCircConv_cuda_kernel (float *xx, float *yy, float *xxyy, unsigned int nSamp)
{
  unsigned int k, x, y, z, idx;
  float tmp;

  // compute the thread number
  x = (unsigned int) threadIdx.x + (unsigned int) blockDim.x * (unsigned int) blockIdx.x;
  y = (unsigned int) threadIdx.y + (unsigned int) blockDim.y * (unsigned int) blockIdx.y;
  z = (unsigned int) threadIdx.z + (unsigned int) blockDim.z * (unsigned int) blockIdx.z;
  idx = (unsigned int) blockDim.y * (unsigned int) gridDim.y * (unsigned int) blockDim.x * (unsigned int) gridDim.x * z +
        (unsigned int) blockDim.x * (unsigned int) gridDim.x * y + x;
  if (idx >= nSamp)
     { printf ("Out of the data array: %u!\n", idx);
       return;                                             // safety precaution
     }

  tmp = 0.0;
  for (k = 0; k < nSamp; k++)
    tmp += xx[k] * yy[(idx + k) % nSamp];
  xxyy[idx] += tmp;
}

static double get_delta_time(void)
{
  static struct timespec t0,t1;

  t0 = t1;
  if(clock_gettime(CLOCK_MONOTONIC,&t1) != 0)
  {
    perror("clock_gettime");
    exit(1);
  }
  return (double)(t1.tv_sec - t0.tv_sec) + 1.0e-9 * (double)(t1.tv_nsec - t0.tv_nsec);
}
