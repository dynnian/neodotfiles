/*       ____             __                                               */
/*      / __ \_________ _/ /_____                                          */
/*     / / / / ___/ __ `/ //_/ _ \                                         */
/*    / /_/ / /  / /_/ / ,< /  __/  Clay Gomera (Drake)                    */
/*   /_____/_/   \__,_/_/|_|\___/   My custom dwm build                    */

#define MAX(A, B)               ((A) > (B) ? (A) : (B))
#define MIN(A, B)               ((A) < (B) ? (A) : (B))
#define BETWEEN(X, A, B)        ((A) <= (X) && (X) <= (B))

void die(const char *fmt, ...);
void *ecalloc(size_t nmemb, size_t size);

