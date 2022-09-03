
#include <stdlib.h>
#include "args.h"

int main(int argc, char **argv) {
    ARG_ENTRY parsed[0xFF]; // allocate 255 args max
    parse(--argc, &argv[1], &parsed[0]); // set globals and parse vars

    
}