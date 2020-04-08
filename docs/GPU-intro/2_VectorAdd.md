---
title: "2 Vector Add"
date: 2020-02-25
draft: false
---

In this tutorial, a step by step vector addition on GPU will be shown.
This kind of operation is known as SAXPY (Single-precision A*X Plus Y).

## CPU version

Write a cuda kernel to add two vectors.
First, consider a serial CPU code.

```.cpp
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include <cuda.h>
#include <cuda_runtime.h>

#define MAX_ERR 1e-6

using namespace std;


void cpu_vector_add(float *h_out, float *h_a, float *h_b, int n) {
    for(int i = 0; i < n; i++){
        h_out[i] = h_a[i] + h_b[i];
    }
}

void CPU_version_wrapper(const int N)
{
    float *h_a, *h_b, *h_out;

    // Allocate memory
    h_a   = (float*)malloc(sizeof(float) * N);
    h_b   = (float*)malloc(sizeof(float) * N);
    h_out = (float*)malloc(sizeof(float) * N);

    // Initialize array
    for(int i = 0; i < N; i++){
        h_a[i] = 1.0;
        h_b[i] = 2.0;
    }

    // Main function
    cpu_vector_add(h_out, h_a, h_b, N);

    for(int i = 0; i < N; i++){
        assert(fabs(h_out[i] - h_a[i] - h_b[i]) < MAX_ERR);
    }
    printf("CPU assertion PASSED\n");
    printf("CPU Last element in the array: out[%d] = %f\n\n",N-1,  h_out[N-1]);

    free(h_a);
    free(h_b);
    free(h_out);
}

int main(){
    const int N = 1024;
    CPU_version_wrapper(N);
    GPU_version_wrapper(N);

    return 0;
}

```

## The CUDA part

### Initialize the data

```.cpp
void GPU_version_wrapper(const int N)
{

    // Allocate CPU memory
    float *h_a, *h_b, *h_out;
    h_a   = (float*)malloc(sizeof(float) * N);
    h_b   = (float*)malloc(sizeof(float) * N);
    h_out = (float*)malloc(sizeof(float) * N);

    // Initialize array
    for(int i = 0; i < N; i++){
        h_a[i] = 1.0;
        h_b[i] = 2.0;
    }

    .
    .
    .
```

### Allocate GPU memory

The GPU has to allocate corresponding amount of memory to handle the data.

```.cpp
    // Allocate device memory for d_a
    float *d_a, *d_b, *d_out;
    cudaMalloc((void**)&d_a, sizeof(float) * N);
    cudaMalloc((void**)&d_b, sizeof(float) * N);
    cudaMalloc((void**)&d_out, sizeof(float) * N);
```

### Transfer data to GPU

Transfer data from host to device memory

```.cpp
  cudaMemcpy(d_a, h_a, sizeof(float) * N, cudaMemcpyHostToDevice);
```

### Call the kernel

```.cpp
gpu_vector_add<<<1,1024>>>(d_out, d_a, d_b, N);
```

### Transfer data from GPU

Transfer data from device memory to host

```.cpp
cudaMemcpy(h_out, d_out, sizeof(float) * N, cudaMemcpyDeviceToHost);
```

### Verify the result

```.cpp
    printf("GPU Last element in the array: out[%d] = %f\n",N-1,  h_out[N-1]);
    for(int i = 0; i < N; i++){
        assert(fabs(h_out[i] - h_a[i] - h_b[i]) < MAX_ERR);
    }

    printf("GPU assertion PASSED\n\n");
```

### Free memory

Cleanup the memory after kernel execution

```.cpp
    .
    .
    .
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_out);
    free(h_a);
    free(h_b);
    free(h_out);
}
```

### The gpu_vector_add kernel

Don't forget to write the actual kernel

```.cpp
__global__ void gpu_vector_add(float *out, float *a, float *b, int n) {
    // built-in variable blockDim.x describes amount threads per block

    int tid = blockIdx.x * blockDim.x + threadIdx.x;
    // Handling arbitrary vector size
    if (tid < n)
        out[tid] = a[tid] + b[tid];

    // more advanced version
    // int i = blockIdx.x * blockDim.x + threadIdx.x;  
    // int step = gridDim.x * blockDim.x;

    // for(; i < n; i += step){
    //     out[i] = a[i] + b[i];
    // }
}
```

## Experiment

Make experiments to gain experiece.

When do you need to introduce the `step` in the cuda kernel?

Try to run the following combinations:

* `gpu_vector_add<<<1,1025>>>(d_out, d_a, d_b, N);`

* `gpu_vector_add<<<2,1024>>>(d_out, d_a, d_b, N);`

* `GPU_version_wrapper(1025);`

### cuda-memcheck

Run your program with the memcheck

```.sh
$ nvcc ex2_vector_add.cu -o ex2_vector_add
$ cuda-memcheck ./ex2_vector_add
```

## Additional Reading

<https://devblogs.nvidia.com/easy-introduction-cuda-c-and-c/>

<https://devblogs.nvidia.com/six-ways-saxpy/>
