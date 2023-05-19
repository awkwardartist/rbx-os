#include "lib.h"

#define ARGC_MIN 2
#define LINE_MAX 128

char *Caller;

void Help() {
   printf("%s SCRIPT [args]\n",Caller);
}

char *GetLine(FILE *File) {
    char *line;

    line = malloc(LINE_MAX);
    if(!fgets(line, LINE_MAX, File)) {
        return 0;
    }

    return line;
}

int main(int argc, char **argv) {
    char *script;
    FILE *fptr;
    char *line;

    Caller = *argv;

    if(argc < ARGC_MIN) {
        Help();
        return 0;
    }

    script = argv[1];
    fptr = fopen(script,"r");

    while(line=GetLine(fptr)) {

        free(line);
    }
    
    return 0;
}