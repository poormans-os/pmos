#pragma once

#include "stdio.h"

#define bf__TAPE_LEN 1024

typedef struct
{
    char *program;
    int len;
    char outBuffer[1024];
} bf__data;

enum bf__tokens
{
    LEFT_ARROW,    // <
    RIGHT_ARROW,   // >
    PLUS_SIGN,     // +
    MINUS_SIGN,    // -
    OPEN_BRACKET,  // [
    CLOSE_BRACKET, // ]
    DOT,           // .
    COMMA,         // , TODO Implement input
};

int bf__main();