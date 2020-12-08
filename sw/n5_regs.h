#define APB_UART_0_BASE_ADDR    0x40000000
#define APB_UART_1_BASE_ADDR    0x40100000
#define APB_SPI_0_BASE_ADDR     0x40200000
#define APB_SPI_1_BASE_ADDR     0x40300000
#define APB_I2C_0_BASE_ADDR     0x40400000
#define APB_I2C_1_BASE_ADDR     0x40500000
#define APB_PWM32_0_BASE_ADDR   0x40600000
#define APB_PWM32_1_BASE_ADDR   0x40700000
#define APB_TIMER32_0_BASE_ADDR 0x40800000
#define APB_TIMER32_1_BASE_ADDR 0x40900000
#define APB_TIMER32_2_BASE_ADDR 0x40a00000
#define APB_TIMER32_3_BASE_ADDR 0x40b00000
#define APB_WDT32_0_BASE_ADDR   0x40c00000
#define APB_WDT32_1_BASE_ADDR   0x40d00000

/* UART Modules */
#define UART_DATA_REG           0x00000000
#define UART_STATUS_REG         0x00000004
#define UART_CTRL_REG           0x00000004
#define UART_PRESCALER_REG      0x00000008
#define UART_IM_REG             0x0000000C
#define UART_TXFIFOTR_REG       0x00000010
#define UART_RXFIFOTR_REG       0x00000014

unsigned int volatile *const UART0_DATA = (unsigned int *)(APB_UART_0_BASE_ADDR + UART_DATA_REG);
unsigned int volatile *const UART0_STATUS = (unsigned int *)(APB_UART_0_BASE_ADDR + UART_STATUS_REG);
unsigned int volatile *const UART0_CTRL = (unsigned int *)(APB_UART_0_BASE_ADDR + UART_CTRL_REG);
unsigned int volatile *const UART0_PRESCALER = (unsigned int *)(APB_UART_0_BASE_ADDR + UART_PRESCALER_REG);
unsigned int volatile *const UART0_IM = (unsigned int *)(APB_UART_0_BASE_ADDR + UART_IM_REG);
unsigned int volatile *const UART0_TXTH = (unsigned int *)(APB_UART_0_BASE_ADDR + UART_TXFIFOTR_REG);
unsigned int volatile *const UART0_RXTH = (unsigned int *)(APB_UART_0_BASE_ADDR + UART_RXFIFOTR_REG);

unsigned int volatile *const UART1_DATA = (unsigned int *)(APB_UART_1_BASE_ADDR + UART_DATA_REG);
unsigned int volatile *const UART1_STATUS = (unsigned int *)(APB_UART_1_BASE_ADDR + UART_STATUS_REG);
unsigned int volatile *const UART1_CTRL = (unsigned int *)(APB_UART_1_BASE_ADDR + UART_CTRL_REG);
unsigned int volatile *const UART1_PRESCALER = (unsigned int *)(APB_UART_1_BASE_ADDR + UART_PRESCALER_REG);
unsigned int volatile *const UART1_IM = (unsigned int *)(APB_UART_1_BASE_ADDR + UART_IM_REG);
unsigned int volatile *const UART1_TXTH = (unsigned int *)(APB_UART_1_BASE_ADDR + UART_TXFIFOTR_REG);
unsigned int volatile *const UART1_RXTH = (unsigned int *)(APB_UART_1_BASE_ADDR + UART_RXFIFOTR_REG);

/* SPI Master Controllers */
#define SPI_DATA_REG            0x00000000
#define SPI_CTRL_REG            0x00000004
#define SPI_CFG_REG             0x00000008
#define SPI_STATUS_REG          0x00000010
#define SPI_IM_REG              0x00000014


unsigned int volatile *const SPI0_CTRL = (unsigned int *)(APB_SPI_0_BASE_ADDR + SPI_CTRL_REG);
unsigned int volatile *const SPI0_DATA = (unsigned int *)(APB_SPI_0_BASE_ADDR + SPI_DATA_REG);
unsigned int volatile *const SPI0_STATUS = (unsigned int *)(APB_SPI_0_BASE_ADDR + SPI_STATUS_REG);
unsigned int volatile *const SPI0_CFG = (unsigned int *)(APB_SPI_0_BASE_ADDR + SPI_CFG_REG);
unsigned int volatile *const SPI0_IM = (unsigned int *)(APB_SPI_0_BASE_ADDR + SPI_IM_REG);


unsigned int volatile *const SPI1_CTRL = (unsigned int *)(APB_SPI_1_BASE_ADDR + SPI_CTRL_REG);
unsigned int volatile *const SPI1_DATA = (unsigned int *)(APB_SPI_1_BASE_ADDR + SPI_DATA_REG);
unsigned int volatile *const SPI1_STATUS = (unsigned int *)(APB_SPI_1_BASE_ADDR + SPI_STATUS_REG);
unsigned int volatile *const SPI1_CFG = (unsigned int *)(APB_SPI_1_BASE_ADDR + SPI_CFG_REG);
unsigned int volatile *const SPI1_IM = (unsigned int *)(APB_SPI_1_BASE_ADDR + SPI_IM_REG);

/* I2C Modules: I2C00 & I2C1 */

#define     I2C_PRE_LO_REG      0x0
#define     I2C_PRE_HI_REG      0x4
#define     I2C_CTRL_REG        0x8
#define     I2C_TX_REG          0xC
#define     I2C_RX_REG          0x10
#define     I2C_CMD_REG         0x14
#define     I2C_STAT_REG        0x18
#define     I2C_IM_REG          0x1C


unsigned int volatile * const I2C0_PRE_LO = (unsigned int *) (APB_I2C_0_BASE_ADDR + I2C_PRE_LO_REG);
unsigned int volatile * const I2C0_PRE_HI = (unsigned int *) (APB_I2C_0_BASE_ADDR + I2C_PRE_HI_REG);
unsigned int volatile * const I2C0_CTRL = (unsigned int *) (APB_I2C_0_BASE_ADDR + I2C_CTRL_REG);
unsigned int volatile * const I2C0_TX = (unsigned int *) (APB_I2C_0_BASE_ADDR + I2C_TX_REG);
unsigned int volatile * const I2C0_RX = (unsigned int *) (APB_I2C_0_BASE_ADDR + I2C_RX_REG);
unsigned int volatile * const I2C0_CMD = (unsigned int *) (APB_I2C_0_BASE_ADDR + I2C_CMD_REG);
unsigned int volatile * const I2C0_STAT = (unsigned int *) (APB_I2C_0_BASE_ADDR + I2C_STAT_REG);
unsigned int volatile * const I2C0_IM = (unsigned int *) (APB_I2C_0_BASE_ADDR + I2C_IM_REG);


unsigned int volatile * const I2C1_PRE_LO = (unsigned int *) (APB_I2C_1_BASE_ADDR + I2C_PRE_LO_REG);
unsigned int volatile * const I2C1_PRE_HI = (unsigned int *) (APB_I2C_1_BASE_ADDR + I2C_PRE_HI_REG);
unsigned int volatile * const I2C1_CTRL = (unsigned int *) (APB_I2C_1_BASE_ADDR + I2C_CTRL_REG);
unsigned int volatile * const I2C1_TX = (unsigned int *) (APB_I2C_1_BASE_ADDR + I2C_TX_REG);
unsigned int volatile * const I2C1_RX = (unsigned int *) (APB_I2C_1_BASE_ADDR + I2C_RX_REG);
unsigned int volatile * const I2C1_CMD = (unsigned int *) (APB_I2C_1_BASE_ADDR + I2C_CMD_REG);
unsigned int volatile * const I2C1_STAT = (unsigned int *) (APB_I2C_1_BASE_ADDR + I2C_STAT_REG);
unsigned int volatile * const I2C1_IM = (unsigned int *) (APB_I2C_1_BASE_ADDR + I2C_IM_REG);

/* PWM Modules: PWM0 & PWM1 */
#define PWM_CMP1_REG            0x00000004
#define PWM_CMP2_REG            0x00000008
#define PWM_PRE_REG             0x00000010
#define PWM_CTRL_REG            0x00000020

unsigned int volatile *const PWM0_CTRL = (unsigned int *)(APB_PWM32_0_BASE_ADDR + PWM_CTRL_REG);
unsigned int volatile *const PWM0_PRE = (unsigned int *)(APB_PWM32_0_BASE_ADDR + PWM_PRE_REG);
unsigned int volatile *const PWM0_CMP1 = (unsigned int *)(APB_PWM32_0_BASE_ADDR + PWM_CMP1_REG);
unsigned int volatile *const PWM0_CMP2 = (unsigned int *)(APB_PWM32_0_BASE_ADDR + PWM_CMP2_REG);

unsigned int volatile *const PWM1_CTRL = (unsigned int *)(APB_PWM32_1_BASE_ADDR + PWM_CTRL_REG);
unsigned int volatile *const PWM1_PRE = (unsigned int *)(APB_PWM32_1_BASE_ADDR + PWM_PRE_REG);
unsigned int volatile *const PWM1_CMP1 = (unsigned int *)(APB_PWM32_1_BASE_ADDR + PWM_CMP1_REG);
unsigned int volatile *const PWM1_CMP2 = (unsigned int *)(APB_PWM32_1_BASE_ADDR + PWM_CMP2_REG);

/* TIMER32: TMR0, TM1, TMR2 and TMR3 */
#define     TMR_REG             0x00000000
#define     TMR_PRE_REG         0x00000004
#define     TMR_CMP_REG         0x00000008
#define     TMR_STATUS_REG      0x0000000c
#define     TMR_OVCLR_REG       0x00000010
#define     TMR_EN_REG          0x00000014
#define     TMR_IM_REG          0x00000100

unsigned int volatile * const TMR0_EN = (unsigned int *) (APB_TIMER32_0_BASE_ADDR + TMR_EN_REG);
unsigned int volatile * const TMR0 = (unsigned int *) (APB_TIMER32_0_BASE_ADDR + TMR_REG);
unsigned int volatile * const TMR0_STATUS = (unsigned int *) (APB_TIMER32_0_BASE_ADDR + TMR_STATUS_REG);
unsigned int volatile * const TMR0_PRE = (unsigned int *) (APB_TIMER32_0_BASE_ADDR + TMR_PRE_REG);
unsigned int volatile * const TMR0_CMP = (unsigned int *) (APB_TIMER32_0_BASE_ADDR + TMR_CMP_REG);
unsigned int volatile * const TMR0_OVCLR = (unsigned int *) (APB_TIMER32_0_BASE_ADDR + TMR_OVCLR_REG);
unsigned int volatile * const TMR0_IM = (unsigned int *) (APB_TIMER32_0_BASE_ADDR + TMR_IM_REG);

unsigned int volatile * const TMR1_EN = (unsigned int *) (APB_TIMER32_1_BASE_ADDR + TMR_EN_REG);
unsigned int volatile * const TMR1 = (unsigned int *) (APB_TIMER32_1_BASE_ADDR + TMR_REG);
unsigned int volatile * const TMR1_STATUS = (unsigned int *) (APB_TIMER32_1_BASE_ADDR + TMR_STATUS_REG);
unsigned int volatile * const TMR1_PRE = (unsigned int *) (APB_TIMER32_1_BASE_ADDR + TMR_PRE_REG);
unsigned int volatile * const TMR1_CMP = (unsigned int *) (APB_TIMER32_1_BASE_ADDR + TMR_CMP_REG);
unsigned int volatile * const TMR1_OVCLR = (unsigned int *) (APB_TIMER32_1_BASE_ADDR + TMR_OVCLR_REG);
unsigned int volatile * const TMR1_IM = (unsigned int *) (APB_TIMER32_1_BASE_ADDR + TMR_IM_REG);

unsigned int volatile * const TMR2_EN = (unsigned int *) (APB_TIMER32_2_BASE_ADDR + TMR_EN_REG);
unsigned int volatile * const TMR2 = (unsigned int *) (APB_TIMER32_2_BASE_ADDR + TMR_REG);
unsigned int volatile * const TMR2_STATUS = (unsigned int *) (APB_TIMER32_2_BASE_ADDR + TMR_STATUS_REG);
unsigned int volatile * const TMR2_PRE = (unsigned int *) (APB_TIMER32_2_BASE_ADDR + TMR_PRE_REG);
unsigned int volatile * const TMR2_CMP = (unsigned int *) (APB_TIMER32_2_BASE_ADDR + TMR_CMP_REG);
unsigned int volatile * const TMR2_OVCLR = (unsigned int *) (APB_TIMER32_2_BASE_ADDR + TMR_OVCLR_REG);
unsigned int volatile * const TMR2_IM = (unsigned int *) (APB_TIMER32_2_BASE_ADDR + TMR_IM_REG);

unsigned int volatile * const TMR3_EN = (unsigned int *) (APB_TIMER32_3_BASE_ADDR + TMR_EN_REG);
unsigned int volatile * const TMR3 = (unsigned int *) (APB_TIMER32_3_BASE_ADDR + TMR_REG);
unsigned int volatile * const TMR3_STATUS = (unsigned int *) (APB_TIMER32_3_BASE_ADDR + TMR_STATUS_REG);
unsigned int volatile * const TMR3_PRE = (unsigned int *) (APB_TIMER32_3_BASE_ADDR + TMR_PRE_REG);
unsigned int volatile * const TMR3_CMP = (unsigned int *) (APB_TIMER32_3_BASE_ADDR + TMR_CMP_REG);
unsigned int volatile * const TMR3_OVCLR = (unsigned int *) (APB_TIMER32_3_BASE_ADDR + TMR_OVCLR_REG);
unsigned int volatile * const TMR3_IM = (unsigned int *) (APB_TIMER32_3_BASE_ADDR + TMR_IM_REG);