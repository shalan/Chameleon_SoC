
#include "n5_regs.h"

#define GPIO_BASE_ADDR      0x48000000

void gpio_set_dir(unsigned int d) { 
    *((unsigned int *)(GPIO_BASE_ADDR+0x10)) = d; 
}

void gpio_write(unsigned int d) { 
    *((unsigned int *)(GPIO_BASE_ADDR+0x04)) = d; 
}

unsigned int gpio_read() {  
    return *((unsigned int *)(GPIO_BASE_ADDR+0x04));
}

int uart_init(unsigned int n, unsigned int prescaler){
    if(n>1) return -1;
    if(n==1){
        *UART1_PRESCALER = prescaler;
        *UART1_IM = 0;
        *UART1_CTRL = 1;
    }
    else {
        *UART0_PRESCALER = prescaler;
        *UART0_IM = 0;
        *UART0_CTRL = 1;
    }
}

int uart_puts(unsigned int n, unsigned char *msg, unsigned int len){
    int i;
    if(n>1) return -1;
    if(n==0){
        for(i=0; i<len; i++){
            while(*UART0_STATUS&1); // TX Not Full
            *UART0_DATA = msg[i]; 
        }
    }  else {
        for(i=0; i<len; i++){
            while(*UART1_STATUS&1); // TX Not Full
            *UART1_DATA = msg[i]; 
        }
    }   
    return 0;
}

int uart_gets(unsigned int n, unsigned char *msg, unsigned int len){
    int i;
    if(n>1) return -1;
    if(n==0){
        for(i=0; i<len; i++){
            while(*UART0_STATUS&8); // RX Not Empty
            msg[i] = *UART0_DATA;  
        }
    } else {
        for(i=0; i<len; i++){
            while(*UART1_STATUS&8); // RX Not Empty
            msg[i] = *UART1_DATA;  
        }
    }    
    return 0;
}

int main(){
    gpio_set_dir(0xFFFF);
    gpio_write(0x0550);

    uart_init (0, 0);
    uart_puts (0, "Hello World!\n", 13);

    gpio_write(0x0AA0);

    for(int i=0; i<100; i++);

    gpio_write(0x0AA0);

    return 0;
}