
#include "args.h"

int main(int argc, char **argv) {
    parse(--argc, &argv[1]); // set globals and parse vars
}