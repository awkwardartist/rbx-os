#include "args.h"

/*  
Usage:
 *  simc [ -hv ... ] IFILE
 *
Options:
 *  -h, --help          Display the help menu
 *  -o, --out    FILE   Output object file
 *  -t, --target FORM   Output format type,
                        Supported types are
                        elf32, elf64, win32, win64,
                        binary
 *
*/

// long and short argument names
const char *shortform[] = { "-h", "-o", "-t", "-v", NULL };

const char *longform[]  = { 
        "--help", "--out", 
        "--target", "--verbose", NULL
};

// gets a longform string from a 
// shortform argument, contains
// the "--" prefix
char *get_longform(char *sf) {
    for(int i = 0; shortform[i]; i++) {
        // test for shortform name
        if(shortform[i][1] == sf[1]) 
            return strdup(longform[i]); // return duplicated string
    }
}

// call to set global program properties
// using raw command line arguments
void parse(int argc, char **argv, ARG_ENTRY *out) {
    char *a;

    // loop for each argument
    for(int i = 0; i < argc; i++) {
        a = argv[i]; // duplicate argument
        if(*a == '-') {
            // get longform arg 
            // if not longform
            if(*(a+1) != '-') 
                a = get_longform(a); 
            
            a += 2; // trim off '--'
            
            out->Name = a; // set name
            out->Value = 0; // null on default

            out = &out[1]; // increment to next arg
        } else {
            // see if file exists
            FILE *src = fopen(a, "r+"); // try open file
            if(src) {
                // todo: handle input file
            } else if(!(out-sizeof(ARG_ENTRY))->Value) {
                // get previous argument
                ARG_ENTRY *prv = out - sizeof(ARG_ENTRY);

                prv->Value = a; // set value
                prv->Default = NULL; // set to 0
            }
            
        }
    }
}