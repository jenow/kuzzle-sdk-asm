#include <stdio.h>
#include <stdlib.h>

struct Kuzzle {
  unsigned int socket;
  unsigned int host;
  unsigned int port;
};

extern struct Kuzzle* kuzzle(unsigned int, unsigned int);
extern int connect(struct Kuzzle*);
extern const char* info(struct Kuzzle*);
extern const char* query(const struct Kuzzle*, const char*, const char*, const char*, const char*);

int main() {
  struct Kuzzle* k = kuzzle(0x000000, 0x581D);
  printf("%d\n", connect(k));
  printf("%s\n", query(k, "POST", "_search", "index", "collection"));
 // printf("%s\n", info(k));
  // printf("%d\n", k->socket);

  exit(0);
}