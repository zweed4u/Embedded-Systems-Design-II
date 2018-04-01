// Zachary Weeden 2018
// PWM Driver

#include <stdint.h>
#include <stdio.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>

#define ADDR_ENABLE 0x43C00000
#define DUTY_OFFSET 4
#define PERIOD_OFFSET 8

#define MAP_SIZE 4096UL
#define MAP_MASK MAP_SIZE - 1


void set_duty(int duty_value){
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    void* map = mmap(0,MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, ADDR_ENABLE & ~MAP_MASK);
    void * enable = map + (ADDR_ENABLE & MAP_MASK);
    void * duty = enable + DUTY_OFFSET;
    *((uint32_t*)duty) = duty_value;
    munmap(map, MAP_SIZE);
    close(fd);
}

void set_period(int period_value){
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    void* map = mmap(0,MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, ADDR_ENABLE & ~MAP_MASK);
    void * enable = map + (ADDR_ENABLE & MAP_MASK);
    void * period = enable + PERIOD_OFFSET;
    *((uint32_t*)period) = period_value;
    munmap(map, MAP_SIZE);
    close(fd);
}

void set_enable(int enable_value){
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    void* map = mmap(0,MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, ADDR_ENABLE & ~MAP_MASK);
    void * enable = map + (ADDR_ENABLE & MAP_MASK);
    *((uint32_t*)enable) = enable_value;
    munmap(map, MAP_SIZE);
    close(fd);
}
