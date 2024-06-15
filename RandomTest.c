#include <stdio.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
extern int errno;
char* convert_decimal_binary(int a){
    if(a<0){
        a =  (a+128) + 128;
    }
    char* result = (char*)(malloc(sizeof(char)*9)); 
    for(int i=0;i<8;i++){
        result[7-i] = a%2 + '0' - 0;
        a/=2;
    }
    result[8] = '\n';
    return result;
}
int main()
{   
    int fd = open("test.dat",O_CREAT|O_WRONLY);
    if(fd < 0){
        printf("%s\n",strerror(errno));
        exit(-1);
    }
    time_t t; 
    int tempt;
    char buffer[10];
    memset(buffer,0,10);
    int max = -128; 
    int min = 127;
    srand((unsigned) time(&t));
    for(int i=0;i<256;i++){
        tempt = rand();
        tempt = tempt % 256;
        tempt -= 128;
        if(max < tempt)
            max = tempt;
        if(min > tempt)
            min = tempt;
        sprintf(buffer,"%d\n",tempt);
        if(write(fd,buffer,strlen(buffer))<0){
            goto error;
        }
    }
    printf("Max: %d,Min: %d\nMax difference: %d %s\n",max,min,max-min,convert_decimal_binary(max-min));
    close(fd);
    return 0;
error:
    close(fd);
    exit(-1);
}
