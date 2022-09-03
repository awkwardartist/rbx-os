
#include <stdint.h>
#include <stddef.h>

// represents a single argument
// passed to a function, parsed
typedef struct {
    char *Default,      // default value
         *Value,        // value provided to argument
         *Name;         // longform name of the entry 
} ARG_ENTRY;

