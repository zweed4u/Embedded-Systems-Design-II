#include <stdio.h>

int main(){
  printf("hello world\n");
  foo(7);
  return(0);
}

int foo(int a){
  printf("foo\n");
  printf("%d\n",a);
  return(0);
}
