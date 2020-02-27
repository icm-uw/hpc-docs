
#include <iostream>

// functions qualifers:
// __global__ launched by CPU on device (must return void)
// __device__ called from other GPU functions (never CPU)
// __host__ can be executed by CPU
// (can be used together with __device__)

// kernel launch:
// f_name<<<gridDim, blockDim, sharedMem, strId>>>(p1,... pN)

__global__ void print_from_gpu(void) {
    printf("Hello from device! I am threadIdx.x %d in blockIdx.x %d, the blockDim.x is %d \n",
    threadIdx.x, blockIdx.x, blockDim.x);
    printf("Hello from device! I am threadIdx.y %d in blockIdx.y %d, the blockDim.y is %d \n",
    threadIdx.y, blockIdx.y, blockDim.y);
    printf("Hello from device! I am threadIdx.z %d in blockIdx.z %d, the blockDim.z is %d \n",
    threadIdx.z, blockIdx.z, blockDim.z);
}

int main(void) {
    printf("Hello World from host!\n");

    print_from_gpu<<<1,3>>>();  // <<<blocks, threads_per_block>>>

    cudaDeviceSynchronize();
    return 0;
}