#include <stdint.h>
#include <stdio.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>

#define ADDR_ENABLE 0x43C00000
#define PERIOD_OFFSET 4
#define DUTY_OFFSET 8

#define MAP_SIZE 4096UL
#define MAP_MASK MAP_SIZE - 1

void main()
{
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    printf("%d \n", fd);

    void* map = mmap(0,MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, ADDR_ENABLE & ~MAP_MASK);
    printf("%p \n",map);

    void * enable = map + (ADDR_ENABLE & MAP_MASK);
    printf("%p \n",enable);

    *((uint32_t*)enable) = 0x1;
    printf("%u \n",*((uint32_t*)enable));
    
    void * period = enable + PERIOD_OFFSET;
    void * duty = enable + DUTY_OFFSET;
    printf("%p, %p \n",period, duty);

    *((uint32_t*)period) = 5000;
    *((uint32_t*)duty) = 500;
    *((uint32_t*)enable) = 0x0;

    munmap(map, MAP_SIZE);
    close(fd);
}
