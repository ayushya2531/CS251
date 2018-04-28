#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>

#define NUM 10000000

#define CUDA_ERROR_EXIT(str) do{\
                                    cudaError err = cudaGetLastError();\
                                    if( err != cudaSuccess){\
                                             printf("Cuda Error: '%s' for %s\n", cudaGetErrorString(err), str);\
                                             exit(-1);\
                                    }\
                             }while(0);
#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

/*struct num_array{
                    double num1;
                    double num2;
                    double result;
};*/



/*__device__ void xor(int *x, int *y)
{
    	int a = *x & *y;
	int b = ~(*x) & ~(*y);
	int r = ~a & ~b;
	*x = r;
	return;
}*/


__global__ void calculate(int *mem, int num, int o)
{
      
      int i = blockDim.x * blockIdx.x + threadIdx.x;
      if(i > num)
           return;
      // struct num_array *a = (struct num_array *)(mem + (i * 3 * sizeof(double)));
      
	int a = *(mem + i) & *( mem + i + num);
	int b = ~*(mem + i) & ~*(mem + i + num);
	*(mem + i) = ~a & ~b;

	if( blockIdx.x == 0 && threadIdx.x == 0 && o == 1){
	//	printf( "%d \n",*(mem + 2*num ));
		*(mem + num ) = *(mem + 2*num );
	//	printf( "%d \n",*(mem + num ));

	}
      
}

int main(int argc, char **argv)
{
    struct timeval start, end, t_start, t_end;
    int i,seed;
    //struct num_array *pa;
    int *ptr;
    int *sptr;
    int *gpu_mem;   
    unsigned long num = NUM;   /*Default value of num from MACRO*/
    int blocks;

    if(argc == 3){
         num = atoi(argv[1]);   /*Update after checking*/
         if(num <= 0)
               num = NUM;
	 seed = atoi(argv[2]);
    }
     else{
	printf("Correct Usage - ./q2 {number of elements} {seed} \n");
	return 1;
    }
    /* Allocate host (CPU) memory and initialize*/
    srand(seed);
    ptr = (int *)malloc(num * sizeof(int));
    sptr = ptr; 
    for(i=0; i<num; ++i){
       //pa = (struct num_array *) sptr;
       //pa->num1 = (double) i + (double) i * 0.1;
       //pa->num2 = pa->num1 + 1.0;
       *sptr = rand();
	//if( i == num - 1)
	//	printf("last no is %d \n", *sptr);
       sptr += 1;
    }
    
    
    gettimeofday(&t_start, NULL);
    
    /* Allocate GPU memory and copy from CPU --> GPU*/

    cudaMalloc(&gpu_mem, num * sizeof(int));
    CUDA_ERROR_EXIT("cudaMalloc");

    cudaMemcpy(gpu_mem, ptr, num * sizeof(int) , cudaMemcpyHostToDevice);
    CUDA_ERROR_EXIT("cudaMemcpy");
    
    gettimeofday(&start, NULL);
    int s_n = num/2;
    int o = 0;
    if(num % 2)
	o = 1;
    i = s_n;
    while( i>=1)
    {
   
	blocks = i /1024;
    
    	if(i % 1024)
           ++blocks;
	//printf("The call is %d %d \n",i,o);
    	calculate<<<blocks, dim3(1024,1,1)>>>(gpu_mem, i,o);
    	CUDA_ERROR_EXIT("kernel invocation");
    	gettimeofday(&end, NULL);
	//cudaDeviceSynchronize();
	i = i + o;

    	if ( i % 2)
		o = 1;
    	else
		o = 0;
	i = i/2;
 
    }
    
    /* Copy back result*/

    cudaMemcpy(ptr, gpu_mem, num * sizeof(int) , cudaMemcpyDeviceToHost);
    CUDA_ERROR_EXIT("memcpy");
    gettimeofday(&t_end, NULL);
    
    //printf("Total time = %ld microsecs Processsing =%ld microsecs\n", TDIFF(t_start, t_end), TDIFF(start, end));
    cudaFree(gpu_mem);
    //sptr = ptr;
   
    /*Print the result*/ 
    //pa = (struct num_array *) (sptr + (num -1)*3*sizeof(double));
    printf("xor sum = %d\n", *(ptr));

    
    free(ptr);
}
