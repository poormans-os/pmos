#pragma once

#include "mutex.h"
#include <Uefi.h>

#define INT_MAX 2147483647

extern EFI_SYSTEM_TABLE *SystemTable;
extern EFI_BOOT_SERVICES *gBS;

mutex_t printfMutex;
mutex_t scanfMutex;

int scanfPID; //In Use
unsigned char scanfBuffer;

int printf(const char *format, ...);
#define putchar(x) printf("%c", x);
void *memset(void *s, const int c, const size_t count);
size_t strlen(const char *str);
unsigned char getchar();
char *fgets(char *str, int n);
int scanf(const char *format, ...);
int kernelScanf();
