#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<string.h>
#include<pthread.h>
#include<math.h>

#define SEED 0x7457
#define MAXX 2147483647
#define MAX_THREADS 64
#define USAGE_EXIT(s) do{ \
                             printf("Usage: %s <# of elements> <# of threads> \n %s\n", argv[0], s); \
                            exit(-1);\
                    }while(0);

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))
#define min(a,b) (a<b?a:b) 

struct thread_param{
                       pthread_t tid;
                       int *array;
                       int size;
                       int skip;
                       int thread_ctr;
                       int max;  
                       int max_index;
                       int is_prime;
};


int check_prime(int element)
{
    int ind, chep = 1;
    for(ind = 2; ind <= sqrt(element); ind++ )
        if(element%ind == 0)
        {
          chep = 0;
          break;
        }
    return(chep);
              
}

void* find_max_prime(void *arg)
{
     struct thread_param *param = (struct thread_param *) arg;
     int ctr = param->thread_ctr;

     param->is_prime = check_prime(param->array[ctr]);

     param->max = -1;
     if(param->is_prime) 
     {
        param->max = param->array[ctr];
        param->max_index = ctr;
     }
     
     ctr += param->skip;
     
     while(ctr < param->size){
          param->is_prime = check_prime(param->array[ctr]);

          if(param->array[ctr] > param->max && param->is_prime){
                param->max = param->array[ctr];
                param->max_index = ctr;
           }
           ctr += param->skip;
     }          
     return NULL;
}

int main(int argc, char **argv)
{
  struct thread_param *params;
  struct timeval start, end;
  int *a, num_elements, ctr, num_threads;
  int max;
  int max_index;

  if(argc !=3)
           USAGE_EXIT("not enough parameters");

  num_elements = atoi(argv[1]);
  if(num_elements <=0)
          USAGE_EXIT("invalid num elements");
  
  num_threads = atoi(argv[2]);
  if(num_threads <=0 || num_threads > MAX_THREADS){
          USAGE_EXIT("invalid num of threads");
  }


  /* Parameters seems to be alright. Lets start our business*/

  a = malloc(num_elements * sizeof(int));
  if(!a){
          USAGE_EXIT("invalid num elements, not enough memory");
  }

  srand(SEED);  
  for(ctr=0; ctr<num_elements; ++ctr)
        a[ctr] = random();


  /*Allocate thread specific parameters*/
  params = malloc(num_threads * sizeof(struct thread_param));
  bzero(params, num_threads * sizeof(struct thread_param));

  //gettimeofday(&start, NULL);

  /*Partion data and create threads*/      
  for(ctr=0; ctr < num_threads; ++ctr){
        struct thread_param *param = params + ctr;
        param->size = num_elements;
        param->skip = num_threads;
        param->array = a;
        param->thread_ctr = ctr;
        
        if(pthread_create(&param->tid, NULL, find_max_prime, param) != 0){
              perror("pthread_create");
              exit(-1);
        }
 
  }
  
  /*Wait for threads to finish their execution*/      
  for(ctr=0; ctr < num_threads; ++ctr){
        struct thread_param *param = params + ctr;
        pthread_join(param->tid, NULL);
        if(ctr == 0 || (ctr > 0 && param->max > max)){
             max = param->max;    
             max_index = param->max_index;
        }
  }
  if(max != -1)   
      printf("Max = %d at index=%d\n", max, max_index);
  else
      printf("No Prime Found");
  //gettimeofday(&end, NULL);
  //printf("Time taken = %ld microsecs\n", TDIFF(start, end));
  free(a);
  free(params);
}
