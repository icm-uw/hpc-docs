#include <stdio.h>
#include <numeric>

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

using namespace std;

void cpu_sum(int *x, int n)
{
    int result = 0;
    for(unsigned int i=0; i < n; ++i) { 
        result += x[i];
    }
    printf("CPU result is %d \n", result);
}

__global__ void sum(int *x)
{
    int tid = blockIdx.x * blockDim.x + threadIdx.x;  
    // printf("Hello from device! My threadId = blockIdx.x *blockDim.x + threadIdx.x <=> %d = %d * %d + %d \n",
    // tidx blockIdx.x, blockDim.x, threadIdx.x);

    // for(unsigned int s=1; s < blockDim.x; s *= 2) {
    //     if (tid % (2*s) == 0) {
    //         printf("x[%d] = %d \n", tid,x[tid] );
    //         x[tid] += x[tid + s];
    //     }
    //     __syncthreads();
    // }
    
    int step  = 1;
    while (step < blockDim.x)
    {
        if (tid % step == 0)
        {   
            //printf("tid = %d \n", tid);
            x[tid] = x[tid] + x[tid+step];
        }   
        //__syncthreads();
        step *= 2;
    }
}

int main()
{
    int h[] = {10, 1, 8, -1, 0, -2, 3, 5, -2, -3, 2, 7, 0, 11, 0, 2};
    
    int size = sizeof(h);
    int count = size/sizeof(int);
    
	int* d;
	cudaMalloc(&d, size);
	cudaMemcpy(d, h, size, cudaMemcpyHostToDevice);

    sum <<<1, count >>>(d);  // <<<blocks, threads_per_block>>>

    int result;
	cudaMemcpy(&result, d, sizeof(int), cudaMemcpyDeviceToHost);
    printf("GPU Sum is %d \n",result);
    
    cpu_sum(h, count);

    // int* processed_d   = (int*)malloc(size);
    // cudaMemcpy(processed_d, d, size, cudaMemcpyDeviceToHost);
    
    // for (int i = 0; i < count; ++i)
    //      cout << "processed_d[" << i << "] " << processed_d[i] << endl;

    cudaFree(d);
	return 0;
}
