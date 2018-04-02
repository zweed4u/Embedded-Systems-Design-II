// Zachary Weeden 2018 - Memory Access Unit Test
// Usage: ./param_mem_test 0xADDRESS_HERE

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <assert.h>

#define MAP_SIZE 4096UL
#define MAP_MASK MAP_SIZE - 1

int main(char **argv)
{   
    uint64_t address = strtoull(argv[optind+0], NULL, 0);

    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    void* map = mmap(0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, address & ~MAP_MASK);
    void * v_address = map + (address & MAP_MASK);

    int val = 1;
   
    *((uint32_t*)v_address) = val;
    printf("Wrote: 0x%x (%lu)\nRead: 0x%x (%lu)\nAddress: %p\n", val, val, *((uint32_t*)v_address), *((uint32_t*)v_address), v_address);
    assert(val==*((uint32_t*)v_address));

    munmap(map, MAP_SIZE);
    close(fd);

    return 0;
}
