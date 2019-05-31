![IconImage](https://cdn6.aptoide.com/imgs/e/3/5/e35291e56c21fd9c639cfcccaa86de35_icon.png?w=256)

# MuP-Design-Project
Soda Dispensing Machine Design done as a part of Second Year Computer Science Course : Microprocessors and Interfacing (CS-F241)

***
# Problem Statement
Make a Soda Dispencing Machine that can dispence three different types of drinks in three different quantities : Small, Medium and Large. There are buttons to select cold drink and sizes. LED's are available with each button. Whenever choice is made and user enters the required number of coins, corresponding LED's glow and dispencing is done. The machine cancels dispencing in cases when the drink is not available in sufficient quantity or the incorrect number of coins are entered. There are LED's to indicate those too. <br><br>
![MachineImage](https://github.com/0110G/MuP-Design-Project/blob/master/Ima/Mup1.png)

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
