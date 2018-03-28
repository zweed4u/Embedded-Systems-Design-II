// Zachary Weeden 2018 - Memory Access Unit Test

#include <stdio.h>
#include <assert.h>
int main()
{   
    //Use addresses instead of malloc once map known
    int *address_ptr = (int*)malloc(sizeof(int) * 1);

    // Data we are writing
    *address_ptr = 0xFFFFFFFF;
    int val = (int)*address_ptr;

    printf("Wrote: 0x%x (%lu)\nRead: 0x%x (%lu)\nAddress: %p\n", *address_ptr, *address_ptr, val, val, (void*)address_ptr);
    assert(val==*address_ptr);

    free(address_ptr);

    return 0;
}
