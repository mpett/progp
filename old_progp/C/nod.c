#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "nod.h"

void writePost(Post * p) {
	printf("Namn: %s\nbmi: %.2f\n",p->name, p->bmi);
}

void writeList(Post * p) {
	Post * temp = p;
	
	if(!p->name) return;

	while(temp) {
		writePost(temp);
		temp = temp->next;
	}
}

Post * find(int (* compare) (Post *  a, Post * b), Post seeked, Post * list) {
	Post * temp = list;
	
	while(temp) {
		if (compare(temp, &seeked) == 0) return temp;
		temp = temp->next;
	}
	return NULL;
}

int compare_names(Post * a, Post * b) {
	return strncmp(a->name, b->name, 30);
}

int compare_bmi(Post * a, Post * b) {
	return (a->bmi)-(b->bmi);
}

void insert(Post ** list) {
	char name[NAMESIZ];
	float length;
	float weight;

	printf("Vad heter personen? ");
	fscanf(stdin, "%s", name);
	printf("Hur lång är personen (m)?");
	fscanf(stdin, "%f", &length);
	printf("Hur mycket väger personen avrundat till närmaste heltal (kg)?");
	fscanf(stdin, "%f", &weight);

    	float bmi = weight/(length*length);
	
        Post * p = (Post *) malloc(sizeof(Post));
        strcpy(p->name, name);
        p->bmi = bmi;
            
        p->next = *list;
        *list = p;
}

void load_names(char * filename, Post ** list) {
    char name[NAMESIZ]; /* <- Ful hårdkodning */
    float bmi;
    FILE *fil = fopen(filename, "r");
    Post * p;
    if (fil == NULL) {
	printf("Filen inte funnen.\n");
    } else {
        while (fscanf(fil, "%s %f", name, &bmi) == 2) {
            p = (Post *) malloc(sizeof(Post));
            strcpy(p->name, name);
            p->bmi = bmi;
            
            p->next = *list;
            *list = p;
        }
    }
}

void delete_name(Post ** list) {
	Post * current;
	Post * previous = *list;
	char name[NAMESIZ];

	printf("Vad heter personen? ");
	fscanf(stdin, "%s", name);
	
	/* Check if first is null */
	if (!previous) return;
	
	/* Check if first element */
	if (strncmp(previous->name, name, NAMESIZ)==0) {
		*list = previous->next;
		free(previous);
		return;
	}
	
	current = previous->next;
	
	/* Check if second is null */
	if (!current) return;
	
	while (current) {
		if (strncmp(current->name, name, NAMESIZ)==0) {
			if (current->next) previous->next = current->next; /* Check not last */
			else previous->next = NULL;
			free(current);
			return;
		}
		previous = current;
		current = current->next;
	}
}

