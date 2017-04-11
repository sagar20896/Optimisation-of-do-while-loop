#include <stdio.h>

#define KRED  "\x1B[31m"
#define KGRN  "\x1B[32m"
#define KBLU  "\x1B[34m"
#define KYEL  "\x1B[33m"
#define KNRM  "\x1B[0m"


int main() {
    printf("%sHello in red\n", KRED);
    printf("%sHello in yellow%s Hello in green\n", KYEL, KGRN);
    printf("%s", KNRM);
}
