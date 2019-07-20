![IconImage](https://cdn6.aptoide.com/imgs/e/3/5/e35291e56c21fd9c639cfcccaa86de35_icon.png?w=256)

# MuP-Design-Project
Soda Dispensing Machine Design done as a part of Second Year Computer Science Course : Microprocessors and Interfacing (CS-F241)
Author : Bhavya Saraf, B.E. Computer Science, BITS Pilani K.K. Birla Goa Campus

***
# Problem Statement
Make a Soda Dispencing Machine that can dispence three different types of drinks in three different quantities : Small, Medium and Large. There are buttons to select cold drink and sizes. LED's are available with each button. Whenever choice is made and user enters the required number of coins, corresponding LED's glow and dispencing is done. The machine cancels dispencing in cases when the drink is not available in sufficient quantity or the incorrect number of coins are entered. There are LED's to indicate those too. <br><br>
![MachineImage](https://github.com/0110G/MuP-Design-Project/blob/master/Ima/Mup1.png)

***
# Flow Chart
![FlowChart](https://github.com/0110G/MuP-Design-Project/blob/master/Ima/Screenshot%20from%202019-05-31%2008-21-39.png)

* START: This is the idle phase. No LEDs glow during this time.
* DRINK_TYPE_SELECTED: User presses the button corresponding to the drink he/she
wants. The LED corresponding to that drink glows.
* DRINK_QTY_SELECTED: User presses the button corresponding to the amount of
drink he/she wants. The LED corresponding to that drink glows.
* SUFFICIENCY CHECK: It checks whether the required amount of the drink ordered
by the customer is available or not.
* GLOW NOT AVAILABLE: If the drink is not available, this glows the NOT AVAILABLE
LED corresponding to the drink ordered.
* DISPENSE_SELECTED: User presses the dispense button after entering the required
number of coins.
* VALIDITY CHECK: It checks whether the user entered the required number of coins
or not.
* DISPENSE: If the user entered the right number of coins, then the drink is dispensed
and the DISPENSE LED glows throughout the dispense process.

***
# Hardware Used
Sr No. | Device | Description | Quantity | Brief Purpose
-------|--------|--------- | ------------| -------------
1 | OR Gates | 2 Input OR Gates | 10 | For Memory Interfacing
2 | NOT Gates | Not Gate | 2 | To Generate MEMR', MEMW' IOR', IOW' signals
3 | 74LS138 | Decoder | 2 | Decding IO and Memory Devices
4 | 74LS245 | Buffer | 2 | Help in Bidirectional Data Transfer
5 | 74LS373 | Latch | 3 | Demultiplexing Address and Data Lines
6 | 2732 | 4 KB ROM | 4 | For Code Segment(Write Only)
7 | 6116 | 2 KB RAM | 2 | For Data Segment(Read, Write)
8 | 8086 | Microprocessor | 1 | Execute Instructions, Generate IO Signals
9 | 8253 | Programmable timer | 2 | For Interrupts and Dispesing Duration
10 | 8255 | Programmable Peripheral Device | 2 | For Interfacing Buttons and LED's
11 | 8259 | Programmable Interrupt Controller | 1 | Generating Maskable Interrupts
12 | ADC0808 | Analog To Digital Converter | 1 | To Convert Coin Detector Analog signal to Digital Signal
13 | Button | Button | 7 | For User To choose drinks, sizes and dispence
14 | L293D | Push-Pull 4 channel | 3 | Control Stepper Motor
15 | LED | Red LEDs | 10 | To indicate current choice
16 | Stepper Motor | Unipolar Stepper Motor | 3 | To Dispece Drink
17 | MPX4250 | Pressure Sensor | 1 | Detect Number of Coins 
18 | SW-SPDT-MOM | Momentary Interactive Switch | 1 | Processor Reset

# Interfacing 

**Memory**<br>
RAM : 2KB+2KB = 4 KB<br>
ROM : 8KB+8KB = 16KB<br>
* Random Access Memory (RAM):<br>
Starting address – 02000H<br>
Ending address – 02FFFH<br>
Even bank begins at 02000H and ends at 02FFEH<br>
Odd bank begins at 02001H and ends at 02FFFH<br>
* Read Only Memory (ROM):<br>
1. ROM 1(8 KB)<br>
Starting address – 00000H<br>
Ending address – 01FFFH<br>
Even bank begins at 00000H and ends at 01FFEH<br>
Odd bank begins at 00001H and ends at 01FFFH<br>
2. ROM 2(8 KB)<br>
Starting address – FE000H<br>
Ending address – FFFFFH<br>
Even bank begins at FE000H and ends at FFFFEH<br>
Odd bank begins at FE001H and ends at FFFFFH<br>

**IO (Using I/O Mapped I/O)**<br>
Mapping of 8255(1):<br>
Port A: 00h<br>
Port B: 02h<br>
Port C: 04h<br>
Control Register: 06h<br>
Mapping of 8255(2):<br>
Port A: 10h<br>
Port B: 12h<br>
Port C: 14h<br>
Control Register: 16h<br>
Mapping of 8253(1):<br>
Counter 0: 20h<br>
Counter 1: 22h<br>
Counter 2: 24h<br>
Control Register: 26h<br>
Mapping of 8253(2):<br>
Counter 0: 40h<br>
Counter 1: 42h<br>
Counter 2: 44h<br>
Control Register: 46h<br>
Mapping of 8259:<br>
Address 0: 30h<br>
Address 1: 32h<br>
