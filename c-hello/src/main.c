#include <stdio.h>

/**
 * Fibonacci - recursive
 * f(0) = 0
 * f(1) = 1
 * f(n) = f(n-1) + f(n-2)
 */
long fibonacci(int n) {
  if (n <= 1) {
    return n;
  }
  return fibonacci(n-1) + fibonacci(n-2);
}

int main(void) {
  printf("%ld", fibonacci(2));
}
