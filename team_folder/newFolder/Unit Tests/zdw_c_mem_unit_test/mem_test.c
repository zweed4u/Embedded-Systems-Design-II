// Zachary Weeden 2018 - Memory Access Unit Test

#include <stdio.h>
#include <assert.h>
int main()
{   
    // Use addresses instead of malloc once map known
    // address_ptr store random accessible memory address
    int *address_ptr = (int*)malloc(sizeof(int) * 1);

    // Write 1s to the address that is store in address_ptr
    *address_ptr = 0xFFFFFFFF;

    // Assign the contents of the malloc address (1s) to 'var'
    int val = (int)*address_ptr;

    printf("Wrote: 0x%x (%lu)\nRead: 0x%x (%lu)\nAddress: %p\n", *address_ptr, *address_ptr, val, val, address_ptr);
    assert(val==*address_ptr);

    free(address_ptr);

    return 0;
}
