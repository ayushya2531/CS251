#include<stdio.h>
#include<stdlib.h>
#include<fcntl.h>
#include<pthread.h>

#define THREADS 1
#define BLOCK_SIZE 64
#define N_ACCS 10000

pthread_mutex_t lock;
static int *acc_bal;
static int **transacts;


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


unsigned long calculate_and_store_hash(char *ptr, char *endptr)
{
    unsigned long hashval = 0;
    int count = BLOCK_SIZE/sizeof(unsigned long);
    while(count--){
         if((endptr - ptr) < sizeof(unsigned long))
                break;
         hashval += *((unsigned long *)ptr);
         ptr += sizeof(unsigned long);
    }
   return hashval;
}

void *banker(void *arg)
/*Argument is the end pointer*/
{

   int *thre_no = (char *)arg;

   while(1){
        pthread_mutex_lock(&lock);
        if(dataptr >= endptr){
              pthread_mutex_unlock(&lock);
              break;
        }
        cptr = dataptr;
        dataptr += BLOCK_SIZE;
        
        chash = optr;
        optr++;
        pthread_mutex_unlock(&lock);
   
        /*Perform the real calculation*/
        *chash = calculate_and_store_hash(cptr, endptr); 
  }
  pthread_exit(NULL); 
}

int main(int argc, char **argv)
{
     int ftrans, facc, ctr, *balance;
     unsigned long sizeacc, sizetrans, bytes_read = 0;
     char *buffacc, *bufftrans, *cbuffacc, *cbufftrans;
     int **tr;
     

     if(argc != 4){
            printf("Usage: %s <Account filename> <Transaction filename> <# Transaction> <# threads>\n", argv[0]);
            exit(-1);         
      }  
     facc = open(argv[1], O_RDONLY);
     if(facc < 0){
           printf("Can not open Account file\n");
           exit(-1);
     } 
    
     ftrans = open(argv[2], O_RDONLY);
     if(ftrans < 0){
           printf("Can not open Transaction file\n");
           exit(-1);
     } 

    sizeacc = lseek(facc, 0, SEEK_END);
    if(size <= 0){
           perror("lseek");
           exit(-1);
    }
    
    if(lseek(facc, 0, SEEK_SET) != 0){
           perror("lseek");
           exit(-1);
    }

    sizetrans = lseek(ftrans, 0, SEEK_END);
    if(sizetrans <= 0){
           perror("lseek");
           exit(-1);
    }
    
    if(lseek(ftrans, 0, SEEK_SET) != 0){
           perror("lseek");
           exit(-1);
    }
   
    bufftrans = malloc(sizetrans);
    if(!bufftrans){
           perror("mem");
           exit(-1);
    }

    buffacc = malloc(sizeacc);
    if(!buffacc){
           perror("mem");
           exit(-1);
    }   
   /*Read the complete file into buff
     XXX Better implemented using mmap */
    
    pthread_t threads[argv[4]];
    int n_tr = argv[3]

    do{
         unsigned long bytes;
         cbufftrans = bufftrans + bytes_read;
         bytes = read(ftrans, cbufftrans, sizetrans - bytes_read);
         if(bytes < 0){
             perror("read");
             exit(-1);
         }
        bytes_read += bytes;
     }while(size != bytes_read);

     bytes_read = 0;
    do{
         unsigned long bytes;
         cbuffacc = buffacc + bytes_read;
         bytes = read(facc, cbuffacc, sizeacc - bytes_read);
         if(bytes < 0){
             perror("read");
             exit(-1);
         }
        bytes_read += bytes;
     }while(size != bytes_read);

      balance = malloc(sizeof(int) * N_ACCS);  
      
      tr = malloc( n_tr*sizeof(int *) );       
      if (tr == NULL)
          exit(-1);
      for (ctr = 0 ; ctr < n_tr ; ctr++) 
      {
          tr[ctr] = malloc( 5*sizeof(int) );     
          if (tr[ctr] == NULL)
              return;
      }
      acc_bal = balance;
      transacts = tr;

     char *st1 = buffacc;
     char *st2 = bufftrans;
     char *line;
     int acc_num, bal;



     for(ctr=0; ; ctr++, st1 = NULL){
            line = strtok_r(st1, '\n');
            if( line == NULL)
              break
            else{
              sscanf(line, "%d %d", &acc_num, &bal);
              balance[acc_num - 1001] = bal;
            }
      }
      for(ctr=0; ; ctr++, st2 = NULL){
            line = strtok_r(st2, '\n');
            if( line == NULL)
              break
            else{
              sscanf(line, "%d %d %d %d %d", &tr[ctr][0], &tr[ctr][1], &tr[ctr][2], &tr[ctr][3], &tr[ctr][4]);
              }
      }

     pthread_mutex_init(&lock, NULL);
  
     for(ctr=0; ctr < THREADS; ++ctr){
        if(pthread_create(&threads[ctr], NULL, banker, &ctr) != 0){
              perror("pthread_create");
              exit(-1);
        }
 
     }

 
    
     for(ctr=0; ctr < hash_count; ++ctr)
           printf("block# %d hash %lx\n", ctr, hashes[ctr]);  
     
     free(hashes);
     free(buff);
     close(fd);
}

