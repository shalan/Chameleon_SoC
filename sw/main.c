//#define RV
//#define TEST5

#ifdef RV
#define printf
#define FLAG_UP  {*flag_ptr=1;}
#else
#include <stdio.h> 
#define FLAG_UP
#endif

volatile int* const flag_ptr = (int *)0x80000AA0;
typedef unsigned int uint32_t;
typedef unsigned char uint8_t;

unsigned int
__mulsi3 (unsigned int a, unsigned int b)
{
  unsigned int r = 0;

  while (a)
    {
      if (a & 1)
	r += b;
      a >>= 1;
      b <<= 1;
    }
  return r;
}

void *
memcpy (void *dest, const void *src, int len)
{
  char *d = dest;
  const char *s = src;
  while (len--)
    *d++ = *s++;
  return dest;
}

int mul (unsigned int a, unsigned int b)
{
  unsigned int r = 0;

  while (a)
    {
      if (a & 1)
	r += b;
      a >>= 1;
      b <<= 1;
    }
  return r;
}

int fact(int n){
    int f = 1;
    for(int i=2; i<10; i++)
        f = mul(f, i);
    return f;
}

void encrypt (uint32_t v[2], const uint32_t k[4]) {
    uint32_t v0=v[0], v1=v[1], sum=0, i;           /* set up */
    uint32_t delta=0x9E3779B9;                     /* a key schedule constant */
    uint32_t k0=k[0], k1=k[1], k2=k[2], k3=k[3];   /* cache key */
    for (i=0; i<32; i++) {                         /* basic cycle start */
        sum += delta;
        v0 += ((v1<<4) + k0) ^ (v1 + sum) ^ ((v1>>5) + k1);
        v1 += ((v0<<4) + k2) ^ (v0 + sum) ^ ((v0>>5) + k3);
    }                                              /* end cycle */
    v[0]=v0; v[1]=v1;
}

void decrypt (uint32_t v[2], const uint32_t k[4]) {
    uint32_t v0=v[0], v1=v[1], sum=0xC6EF3720, i;  /* set up; sum is 32*delta */
    uint32_t delta=0x9E3779B9;                     /* a key schedule constant */
    uint32_t k0=k[0], k1=k[1], k2=k[2], k3=k[3];   /* cache key */
    for (i=0; i<32; i++) {                         /* basic cycle start */
        v1 -= ((v0<<4) + k2) ^ (v0 + sum) ^ ((v0>>5) + k3);
        v0 -= ((v1<<4) + k0) ^ (v1 + sum) ^ ((v1>>5) + k1);
        sum -= delta;
    }                                              /* end cycle */
    v[0]=v0; v[1]=v1;
}

// TEST3
void unsigned_divide(unsigned int dividend,
		     unsigned int divisor,
		     unsigned int *quotient,
		     unsigned int *remainder )
{
  unsigned int t, num_bits;
  unsigned int q, bit, d;
  int i;

  *remainder = 0;
  *quotient = 0;

  if (divisor == 0)
    return;

  if (divisor > dividend) {
    *remainder = dividend;
    return;
  }

  if (divisor == dividend) {
    *quotient = 1;
    return;
  }

  num_bits = 32;

  while (*remainder < divisor) {
    bit = (dividend & 0x80000000) >> 31;
    *remainder = (*remainder << 1) | bit;
    d = dividend;
    dividend = dividend << 1;
    num_bits--;
  }


  /* The loop, above, always goes one iteration too far.
     To avoid inserting an "if" statement inside the loop
     the last iteration is simply reversed. */

  dividend = d;
  *remainder = *remainder >> 1;
  num_bits++;

  for (i = 0; i < num_bits; i++) {
    bit = (dividend & 0x80000000) >> 31;
    *remainder = (*remainder << 1) | bit;
    t = *remainder - divisor;
    q = !((t & 0x80000000) >> 31);
    dividend = dividend << 1;
    *quotient = (*quotient << 1) | q;
    if (q) {
       *remainder = t;
     }
  }
}  /* unsigned_divide */

const unsigned char CRC7_POLY = 0x91;
 
unsigned char getCRC(unsigned char message[], unsigned char length)
{
  unsigned char i, j, crc = 0;
 
  for (i = 0; i < length; i++)
  {
    crc ^= message[i];
    for (j = 0; j < 8; j++)
    {
      if (crc & 1)
        crc ^= CRC7_POLY;
      crc >>= 1;
    }
  }
  return crc;
}

// Test 5
int rec_fact(int n) {
    if (n>=1)
        return n*rec_fact(n-1);
    else
        return 1;
}

// test 6
void quick_sort(int a[], int l, int r)
{
	int i, j, p, tmp;
	int m, min, max;

	i = l;
	j = r;
	m = (l + r) >> 1;

	if (a[m] >= a[l]) {
		max = a[m];
		min = a[l];
	} else {
		max = a[l];
		min = a[m];
	}

	if (a[r] >= max)
		p = max;
	else {
		if (a[r] >= min)
			p = a[r];
		else
			p = min;
	}

	do {
		while (a[i] < p)
			i++;
		while (p < a[j])
			j--;
		if (i <= j) {
			tmp = a[i];
			a[i] = a[j];
			a[j] = tmp;
			i++;
			j--;
		}
	} while (i <= j);

	if (l < j)
		quick_sort(a, l, j);
	if (i < r)
		quick_sort(a, i, r);
}

// Test 8
static uint8_t aes_sbox[256];   /** AES S-box  */
static uint8_t aes_isbox[256];  /** AES iS-box */
void AES_generateSBox(void)
{
    uint32_t t[256], i;
    uint32_t x;
    for (i = 0, x = 1; i < 256; i ++)
    {
        t[i] = x;
        x ^= (x << 1) ^ ((x >> 7) * 0x11B);
    }

    aes_sbox[0] = 0x63;
    for (i = 0; i < 255; i ++)
    {
        x = t[255 - i];
        x |= x << 8;
        x ^= (x >> 4) ^ (x >> 5) ^ (x >> 6) ^ (x >> 7);
        aes_sbox[t[i]] = (x ^ 0x63) & 0xFF;
    }
    for (i = 0; i < 256;i++)
    {
         aes_isbox[aes_sbox[i]]=i;
    }
}
// test 9
typedef unsigned uint;
int is_prime(uint n)
{
        if (!(n%2) || !(n%3)) return 0;
        uint p = 1;
        while(p*p < n)
                if (n%(p += 4) == 0 || n%(p += 2) == 0)
                        return 0;
        return 1;
}
 
uint reverse(uint n)
{
        uint r;
        for (r = 0; n; n /= 10)
                r = r*10 + (n%10);
        return r;
}
 
int is_emirp(uint n)
{
        uint r = reverse(n);
        return r != n && is_prime(n) && is_prime(r);
}

// Test 10
// gcd
int gcd(int a, int b)
{
    if (a == b)
        return a;
 
    // GCD(0, b) == b; GCD(a, 0) == a,
    // GCD(0, 0) == 0
    if (a == 0)
        return b;
    if (b == 0)
        return a;
 
    // look for factors of 2
    if (~a & 1) // a is even
    {
        if (b & 1) // b is odd
            return gcd(a >> 1, b);
        else // both a and b are even
            return gcd(a >> 1, b >> 1) << 1;
    }
 
    if (~b & 1) // a is odd, b is even
        return gcd(a, b >> 1);
 
    // reduce larger number
    if (a > b)
        return gcd((a - b) >> 1, b);
 
    return gcd((b - a) >> 1, a);
}

// TEST 11
// XTEA
void xtea_encipher(unsigned int num_rounds, uint32_t v[2], uint32_t const key[4]) 
{
	unsigned int i;
	uint32_t v0 = v[0], v1 = v[1], sum = 0, delta = 0x9E3779B9;
	for (i = 0; i < num_rounds; i++) 
	{
		v0 += (((v1 << 4) ^ (v1 >> 5)) + v1) ^ (sum + key[sum & 3]);
		sum += delta;
		v1 += (((v0 << 4) ^ (v0 >> 5)) + v0) ^ (sum + key[(sum >> 11) & 3]);
	}
	v[0] = v0; v[1] = v1;
}

// TEST 12
// u32toa
void u32toa(uint32_t value, char* buffer) {
    char temp[10];
    char *p = temp;
    do {
        *p++ = (char)(value % 10) + '0';
        value /= 10;
    } while (value > 0);

    do {
        *buffer++ = *--p;
    } while (p != temp);

    *buffer = '\0';
}

int main(){
    int r = -1;
 
 #ifdef TEST1   
    FLAG_UP;
    r=fact(10)+fact(12);
    FLAG_UP;
    printf("%d\n", r);
#endif
    
#ifdef TEST2
    uint32_t v[2]={20, 30}, k[4]={100, 200, 33, 99};
    FLAG_UP;
    encrypt(v, k);
    decrypt(v, k);
    r = v[0] + v[1];
    FLAG_UP;
    printf("%d\n", r);
#endif

#ifdef TEST3
    int q, sum =0;
    FLAG_UP;
    unsigned_divide(3907632, 304, &q, &r);
    sum += (r + q);
    unsigned_divide(1234567890, 13, &q, &r);
    sum += (r + q);
    FLAG_UP;
    printf("%d\n", r);
#endif

#ifdef TEST4
    char *msg="hello there my lovely lady!";
    FLAG_UP;
    r = getCRC(msg, 20);
    FLAG_UP;
    printf("%d\n", r);
#endif

#ifdef TEST5
    char *msg="hello there my lovely lady!";
    FLAG_UP;
    r = rec_fact(10);
    FLAG_UP;
    printf("%d\n", r);
#endif

#ifdef TEST6
    int a[]={99, 5, 11, 55, 22, 33, 66, 1, 121, 25, 35, 15, 13, 9, 7, 21};
    FLAG_UP;
    quick_sort(a, 0, 15);
    FLAG_UP;
    r = a[0]+a[15]+a[7]+a[8];
    printf("%d\n", r);
#endif
#ifdef TEST7    
    FLAG_UP;
    int sum = 0;
    for(int i=0; i<100; i++)
      sum += mul(i,34589);
    FLAG_UP;
    r = sum;
    printf("%d\n", r);
#endif
#ifdef TEST8    
    FLAG_UP;
    int sum = 0;
    AES_generateSBox();
    for(int i=0; i<256; i++)
      sum += (aes_sbox[i] + aes_isbox[i]);
    FLAG_UP;
    r = sum;
    printf("%d\n", r);
#endif
#ifdef TEST9
    FLAG_UP;
    int sum = 0;
    for (int x = 1; x < 100; x += 2)
      if (is_emirp(x))
        sum += x;
    FLAG_UP;
    r = sum;
    printf("%d\n", r);
#endif
#ifdef TEST10
    FLAG_UP;
    r = gcd(299792458,6447287);
    FLAG_UP;
    printf("%d\n", r);
#endif
#ifdef TEST11
    unsigned int key[4] = { 0xFACE, 0xDEAD, 0xBABE, 0xD00D };
    unsigned v[4]={2345, 6671, 22223, 1992};
    FLAG_UP;
    xtea_encipher(32,v, key);
    //xtea_encipher(32,&v[2], key);
    r = v[0] + v[1];// + v[2] + v[3];
    FLAG_UP;
    printf("%d\n", r);
#endif

#ifdef TEST12
    unsigned int key[4] = { 0xFACE, 0xDEAD, 0xBABE, 0xD00D };
    unsigned v[4]={2345332, 33336671, 44422223, 22221992};
    char str[10];
    r = 0;
    FLAG_UP;
    for(int i=0; i<4; i++)
    {
      u32toa(v[i], str);
      for(int e=0; str[e]!=0; e++)
        r += str[e];
    }
    FLAG_UP;
    printf("%d\n", r);
#endif

    return r;
}