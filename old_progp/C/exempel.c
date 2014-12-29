#include <stdlib.h>
#include <stdio.h>

struct post {
    char name[29];
    float bmi;
    struct post * next;
};

typedef struct post Post;

void writePost(Post * p) {
    printf("Namn: %s\nbmi: %.2f\n", p->name, p->bmi);
}

int main(int argc, char * argv[]) {
    int vikt;
    float lengd;
    Post * p = (Post *) malloc(sizeof(Post));
    p -> next = (Post *) malloc(sizeof(Post));

    printf("Vad heter du? ");
    fscanf(stdin, "%s", p->name);

    printf("Hur l�ng �r du (m)? ");
    fscanf(stdin, "%f", &lengd);
    
    /* Kommer f�rs�ka peka p� positionen lengd i minnet */
    /* fscanf(stdin, "%f", lengd);  */

    printf("Vad v�ger du (kg)? ");
    fscanf(stdin, "%d", &vikt);

    p -> bmi = vikt / (lengd * lengd);

    writePost(p);

    free(p->next);
    free(p);

    return 0;
}
