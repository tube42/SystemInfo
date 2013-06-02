

// assuming rounds=12 and wordsize=32
#define ROUNDS 		12
#define WORDSIZE 	32
#define Q_W		0x9e3779b9
#define P_W		0xb7e15163
#define RC5_SIZE 	26

// rc5-32/12/5
#define RC5_5_KEY_LEN	5
#define RC5_5_C			2
#define RC5_5_T 		26


// rc5-32/12/9
#define RC5_9_KEY_LEN	9
#define RC5_9_C			3
#define RC5_9_T 		26

// FAST with gcc 3.3+
#define ROL(a,b)		(((a) << ((b) & 31)) | ((a) >> (32 - ((b) & 31))))



// the plain RC5-32/12/9 function for 256
int rc5_block_function_plain(unsigned long *p, unsigned long *c, unsigned long *k) {
    unsigned long sch_key[26];
    unsigned long L[3];

    for(unsigned long x = 256; x != 0; ) {
        // setkey:
        L[0] = k[0];
        L[1] = k[1];
        L[2] = --x;

        // schedule key
        int i = 0, j = 0;
        unsigned long A = 0, B = 0;

        sch_key[0] = P_W;
        for(int I = 1; I < RC5_SIZE; I++)  sch_key[I] = sch_key[I-1] + Q_W;

        for(int s = RC5_9_T * 3 ; s != 0; s--) {
            A = sch_key[i] = ROL(sch_key[i]+ A + B, 3);		i = (i + 1) % RC5_SIZE;
            B = L[j] = ROL(L[j] + A+ B, A+B);				j = (j + 1) % RC5_9_C;
        }


        // encrypt
        A = p[0] + sch_key[0];
        B = p[1] + sch_key[1];

        for(i = 1; i <= ROUNDS; i++) {
            A = ROL(A^B, B) + sch_key[2 * i];
            B = ROL(A^B, A) + sch_key[2 * i+1];
        }


        // found it ?
        if(A == c[0] && B == c[1]) {
            k[2] = x;
            return 1;
        }
    }
    return 0;
}


void run_int_benchmark()
{
    unsigned long buffer[16];
    for(int i = 0; i < 16; i++) buffer[i] = i * 0x1234567;

    for(int i = 0; i < 2048; i++) {
        buffer[8] = i;
        rc5_block_function_plain(buffer, buffer + 4, buffer + 8);
        rc5_block_function_plain(buffer, buffer + 4, buffer + 8);
        rc5_block_function_plain(buffer, buffer + 4, buffer + 8);
        rc5_block_function_plain(buffer, buffer + 4, buffer + 8);
    }
}
