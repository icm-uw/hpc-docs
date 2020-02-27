---
title: "1 Hello World"
date: 2020-02-25
draft: false
---


Write a simple `ex1_hello_world.cu` application using cuda.
Experiment with different amount of blocks and threads per block.

```.cpp
#include <iostream>

__global__ void print_from_gpu(void) {
    printf("Hello from device! I am threadIdx.x %d in blockIdx.x %d, the blockDim.x is %d \n",
    threadIdx.x, blockIdx.x, blockDim.x);
}

int main(void) {
    printf("Hello World from host!\n");

    print_from_gpu<<<2,3>>>();  // <<<blocks, threads_per_block>>>

    cudaDeviceSynchronize();
    return 0;
}
```

Compile and run:

```.sh
$ nvcc ex1_hello_world.cu -o hello_world
$ ./hello_world
```
