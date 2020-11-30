#include <stdio.h>
#include <string.h>

int main() {
    char s[] = "Ana are mere si pere";
    char *p = strtok(s, " ");
    while(p) {
        printf("%s\n", p);
        p = strtok(NULL, " ");
    }
    char intString[] = "-123";
    int convertedString = 0;
    int i = 0;
    if (intString[0] = '-') {
        i++;
    }
    while (i < strlen(intString)) {
        int x = intString[i] - '0';
        convertedString = convertedString * 10 + x;
        i++;
    }
    if (intString[0] = '-') {
        convertedString *= -1;
    }
    printf("%d\n", convertedString);
    return 0;
}
