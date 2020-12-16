#include "n5_drv.h"
#include "n5_int.h"


unsigned int A[100];

void IRQ() {
    gpio_write(0x0099);        
}

int fact(int n){
    int f = 1;
    for(int i=2; i<=n; i++)
        f = f * i;
    return f;
}

int strlen(char *s){
    int i=0;
    while (*s){
        i++;
    }
    return i;
}

void M23LC_write_byte(int n, unsigned int addr, unsigned int data){
  spi_start(n);
  spi_write(n, 0x2);
  spi_write(n, addr >> 8);     // Address high byte
  spi_write(n, addr & 0xFF);   // Address low byte
  spi_write(n, data);
  spi_end(n);
}

unsigned char M23LC_read_byte(int n, unsigned short addr){
  spi_start(n);
  spi_write(n, 0x3);
  spi_write(n, addr >> 8);     // Address high byte
  spi_write(n, addr & 0xFF);   // Address low byte
  spi_write(n, 0);             // just write a dummy data to get the data out
  spi_end(n);
  return spi_read(n);
}

#define     DELAY(n)   for(int i=0; i<n; i++)

int main(){
    // Initialization
    uart_init (0, 0);
    gpio_set_dir(0x00FF);
    spi_init(0, 0,0,20);
    
    // Start the test
    uart_puts (0, "Hello World!\n", 13);
    
    // GPIO
    uart_puts (0, "GPIO Test: ", 11);
    gpio_write(0x0055);
    DELAY(100);
    int gpio_data = gpio_read();
    if((gpio_data >> 8) == 0x55)
        uart_puts(0,"Passed!\n", 8);
    else
        uart_puts(0,"Failed!\n", 8);
    
    // External SPM Accelerator
    uart_puts (0, "SPM Test: ", 9);
    int factorial = fact(5);
    DELAY(100);
    if(factorial==120)
        uart_puts(0,"Passed!\n", 8);
    else 
        uart_puts(0,"Failed!\n", 8);

    // SPI
    uart_puts (0, "SPI Test: ", 9);
    M23LC_write_byte(0, 0, 0xA5);
    unsigned int spi_data = M23LC_read_byte(0, 0);
    DELAY(100);
    if(spi_data==0xA5)
        uart_puts(0,"Passed!\n", 8);
    else 
        uart_puts(0,"Failed!\n", 8);

    // PWM
    pwm_init(0, 250, 99, 5);
 	pwm_enable(0);
    DELAY(300);
    pwm_disable(0); 

    // Some Delay
    DELAY(100);
   
    // Done!
    uart_puts(0, "Done!\n\n", 7);
    return 0;
}

/*

    (unsigned int *)(0x49000000) = -20;
    (unsigned int *)(0x49000004) = 50;
    
    int x = 10;
    int y = 50;

    int z = x * y;

    x = fact(5);

    gpio_write(x);

    uart_init (0, 0);
    uart_puts (0, "Hello World!\n", 13);

    gpio_write(z);

    for(int i=0; i<z; i++);

    gpio_write(0x00AA);

    x = 5;
    //asm volatile ("csrrw   zero, mie, %0" :: "r" (x));
    asm volatile ("csrrwi   zero, mie, %0" :: "i" (5));

    x = 0x100;
    asm volatile ("csrrw   zero, 0x310, %0" :: "r" (x));

    gpio_im(0x0100);

    for(int i=0; i<50; i++);
    */