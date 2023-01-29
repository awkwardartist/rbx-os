#include <string.h>

/* 
 * Entry point of the ribbix core daemon.
 * used to control the Linux System.
*/

// global argument info
char  **_ARG_VALUES;
int   _ARG_NUMBER;

// entry
int main (char **argv, int argc) {
    // get global argument values
    _ARG_VALUES=argv;
    _ARG_NUMBER=argc;

    // requires runmode arg
    if (argc < 2) 
        return 1;

    // todo: initialize

    return 0;
}
