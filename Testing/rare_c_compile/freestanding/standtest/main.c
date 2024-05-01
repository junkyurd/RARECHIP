#include <stdlib.h>
#include "qsort.h"

int main(){
        int count;
        //count = 25;
        int number[25] = {42, 23, 31, 1, 5, 17, 9, 22, 18, 19, 28, 78, 92, 67, 13, 45, 57, 98, 70, 30, 11, 2, 0, 91, 62};

        //int seed = 3;
        //srand(seed);
        //for (int s = 0; s < count; s++){
        //      number[s] = rand()%100;
        //}
        quicksort(number,0,25-1);

        return 0;
}

