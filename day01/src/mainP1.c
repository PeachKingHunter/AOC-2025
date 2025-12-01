#include <stdio.h>
#include <stdlib.h>

#define DIAL_MAX 99
#define DIAL_INIT_POS 50

int main() {

  // Open moves's file
  FILE *file = fopen("input.txt", "r");
  if (file == NULL) {
    printf("file not openned\n");
    return -1;
  }

  // Variables
  char line[999];
  int dialVal = DIAL_INIT_POS;
  int pointer0Cpt = 0;

  // Make all moves
  while (fscanf(file, "%s\n", line) == 1) {
    char dir = line[0];
    int dist = atoi(line + 1);

    // Move the dial's pointer
    if (dir == 'L') {
      dialVal -= dist;
    } else if (dir == 'R') {
      dialVal += dist;
    }

    // The dial is circular
    while (dialVal < 0) {
      dialVal += DIAL_MAX + 1;
    }

    while (dialVal > DIAL_MAX) {
      dialVal -= DIAL_MAX + 1;
    }

    // Cpt of pointer on 0
    if (dialVal == 0)
      pointer0Cpt++;
  }

  // Print result
  printf("End pos for the dial: %d\n", dialVal);
  printf("the dial ended %d on 0\n", pointer0Cpt);
  return 0;
}
