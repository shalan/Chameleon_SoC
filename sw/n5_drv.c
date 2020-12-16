#include "n5_regs.h"
#include "n5_drv.h"

/* GPIO */
void gpio_set_dir(unsigned int d) { 
    *GPIO_DIR = d; 
}

void gpio_write(unsigned int d) { 
    *GPIO_DOUT = d;
}

unsigned int gpio_read() {  
    return *GPIO_DIN;
}

void gpio_pull (unsigned char d){
    *GPIO_PD = 0;
    *GPIO_PU = 0;
    if(d==0) *GPIO_PD = 1;
    else *GPIO_PU = 1;
}

void gpio_im(unsigned int im){
    *GPIO_IM = im;
}

/* UART */
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

/* SPI */
int spi_init(unsigned int n, unsigned char cpol, unsigned char cpha, unsigned char clkdiv){
  unsigned int cfg_value = 0;
  cfg_value |=  cpol;
  cfg_value |=  (cpha << 1);
  cfg_value |=  ((unsigned int)clkdiv << 2);
  if(n>1) return -1;
  if(n==0)  *SPI0_CFG = cfg_value;
  else *SPI1_CFG = cfg_value;
}

unsigned int spi_status(unsigned int n){
    if(n>1) return -1;
    if(n==0)    
        return *SPI0_STATUS & 1;
    else 
        return *SPI1_STATUS & 1;
}

unsigned char spi_read(unsigned int n){
    if(n>1) return -1;
    if(n==0)  
        return *SPI0_DATA;
    else 
        return *SPI1_DATA;
}

int spi_write(unsigned int n, unsigned char data){
    if(n>1) return -1;
    if(n==0) {
        *SPI0_DATA =  data;
        SET_BIT(*SPI0_CTRL, SPI_GO_BIT);
        CLR_BIT(*SPI0_CTRL, SPI_GO_BIT);
        while(!spi_status(n));
    } else{
        *SPI1_DATA =  data;
        SET_BIT(*SPI1_CTRL, SPI_GO_BIT);
        CLR_BIT(*SPI1_CTRL, SPI_GO_BIT);
        while(!spi_status(n));
    }
    return 0;
}

int spi_start(unsigned int n){
    if(n>1) return -1;
    if(n==0) {    
        SET_BIT(*SPI0_CTRL, SPI_SS_BIT);
    } else {
        SET_BIT(*SPI1_CTRL, SPI_SS_BIT);
    }
    return 0;
}

int spi_end(unsigned int n){
    if(n>1) return -1;
    if(n==0)    
        CLR_BIT(*SPI0_CTRL, SPI_SS_BIT);
    else 
        CLR_BIT(*SPI1_CTRL, SPI_SS_BIT);
    return 0;
}

/* i2c */
int i2c_init(unsigned int n, unsigned int pre){
    if(n>1) return -1;
    if(n==0) {
        *(I2C0_PRE_LO) = pre & 0xff;
        *(I2C0_PRE_HI) = pre & 0xff00;
        *(I2C0_CTRL) = I2C_CTRL_EN | I2C_CTRL_IEN;
    } else {
        *(I2C1_PRE_LO) = pre & 0xff;
        *(I2C1_PRE_HI) = pre & 0xff00;
        *(I2C1_CTRL) = I2C_CTRL_EN | I2C_CTRL_IEN;
    }
}

int i2c_send(unsigned int n, unsigned char saddr, unsigned char sdata){
    if(n>1) return -1;
    if(n==0) {
        *(I2C0_TX) = saddr;
        *(I2C0_CMD) = I2C_CMD_STA | I2C_CMD_WR;
        while( ((*I2C0_STAT) & I2C_STAT_TIP) != 0 );
        //(*I2C_STAT) & I2C_STAT_TIP ;

        if( ((*I2C0_STAT) & I2C_STAT_RXACK)) {
            *(I2C0_CMD) = I2C_CMD_STO;
            return 0;
        }
        *(I2C0_TX) = sdata;
        *(I2C0_CMD) = I2C_CMD_WR;
        while( (*I2C0_STAT) & I2C_STAT_TIP );
        *(I2C0_CMD) = I2C_CMD_STO;
        if( ((*I2C0_STAT) & I2C_STAT_RXACK ))
            return 0;
        else
            return 1;
    } else {
        *(I2C1_TX) = saddr;
        *(I2C1_CMD) = I2C_CMD_STA | I2C_CMD_WR;
        while( ((*I2C1_STAT) & I2C_STAT_TIP) != 0 );
        //(*I2C_STAT) & I2C_STAT_TIP ;

        if( ((*I2C1_STAT) & I2C_STAT_RXACK)) {
            *(I2C1_CMD) = I2C_CMD_STO;
            return 0;
        }
        *(I2C1_TX) = sdata;
        *(I2C1_CMD) = I2C_CMD_WR;
        while( (*I2C1_STAT) & I2C_STAT_TIP );
        *(I2C1_CMD) = I2C_CMD_STO;
        if( ((*I2C1_STAT) & I2C_STAT_RXACK ))
            return 0;
        else
            return 1;
    }
}

/* PWM */
int pwm_init(unsigned int n, unsigned int cmp1, unsigned int cmp2, unsigned int pre){
  if(n>1) return -1;
    if(n==0) {
        *PWM0_CMP1 = cmp1;
        *PWM0_CMP2 = cmp2;
        *PWM0_PRE = pre;
    } else {
        *PWM1_CMP1 = cmp1;
        *PWM1_CMP2 = cmp2;
        *PWM1_PRE = pre;
    }
    return 0;
}

int pwm_enable(unsigned int n){
    if(n>1) return -1;
    if(n==0) 
        *PWM0_CTRL = 0x1;
    else
        *PWM0_CTRL = 0x1;
    return 0;
}

int pwm_disable(unsigned int n){
    if(n>1) return -1;
    if(n==0) 
        *PWM0_CTRL = 0x0;
    else
        *PWM0_CTRL = 0x0;
    return 0;
}