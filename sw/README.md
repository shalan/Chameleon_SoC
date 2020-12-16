## I/O Map (WIP)
### GPIO Port (Base: 0x48000000)
|Register|Offset|Description|
|----------|---|------------|
| Data In | 0x00 | 14 pins only|
| Data Out| 0x04| 14 pins only|
| Pull Up Enable|0x08| Currently not used|
| Pull Down Enable|0x0C| Currently not used|
| Direction|0x10| 1: Input, 0: Output|
| Interrupt Mask| 0x14||


### UART Modules (UART0 Base: 0x40100000, UART1 Base: 0x40200000)

|Register|Offset|Description|
|----------|---|------------|
| TX/RX Data | 0x00 | Read/Write from/to RX/TX FIFOs |
| STATUS |0x04| Read only|
| CONTROL| 0x04| Write only|
| PRESCALER|0x08| Prescaler for the baud rate generator|
| Interrupts Mask| 0x0C||
| TX FIFO Threshold|0x10||
| RX FIFO Threshold|0x14||


### SPI Modules (SPI0 Base: 0x40200000, SPI1 Base: 0x40300000 )

|Register|Offset|Description|
|----------|---|------------|
| Data |||
| Control |||
| Configuration |||
| Status |||
| Interrupt Mask|||

### I2C Modules (I2C0 Base: 0x40400000, I2C1 Base: 0x40500000)

|Register|Offset|Description|
|----------|---|------------|


### Pulse Width Modulors (PWM0 Base: 0x40600000, PWM1 Base: 0x40700000)

|Register|Offset|Description|
|----------|---|------------|
| CMP1 | 0x04| Compare 1 Register (period)|
| CMP2 | 0x08 | Compare 2 Register (level change) |
| PRESCALER| 0x10| Prescaler Register, tmr_clk = clk / (PRESCALER+1)|
| CTRL| 0x20| Control Register, 0: Enable PWM| 


``PWM Period = (CMP1 + 1)/tmr_clk = (CMP1 + 1)*(PRESCALER + 1)/clk``

``PWM Duty Cyle = 1 - (CMP1 + 1)/(CMP2 + 1)``


### 32-bit Timer Modules (Base: 0x40800000, 0x40900000, 0x40A00000, 0x40B00000)

|Register|Offset|Description|
|----------|---|------------|
| TIMER | 0x00| Current Count |
| Prescaler | 0x04| |
| Compare | 0x08| Compare Register|
| Status|||
| Overflow Clear |||
| Timer Enable |||
| Interrupt Mask |||



### 32-bit Watch Dog Timer Modules (Base: 0x40C00000, 0x40D00000)
|Register|Offset|Description|
|----------|---|------------|
