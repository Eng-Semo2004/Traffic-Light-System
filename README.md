# 🚦Traffic Light System
<b>
A simple embedded system using PIC16F877A simulates a traffic light system between two streets. The system has two modes:

### <ins>Automatic Mode:</ins>
  - West St. (15s Red, 3s Yellow, 20s Green).
  - South St. (23s Red, 3s Yellow, 12s Green).
 
### <ins>Manual Mode:</ins>
  - The yellow LED is ON for 3 seconds, then the streets are switched. 

## 🚀 Key Features
&nbsp;&nbsp;1️⃣ BCD to 7-segment decoders (7448) for Units and Tens. <br>
&nbsp;&nbsp;2️⃣ Enable pins to activate and deactivate the 7-segments. <br>
&nbsp;&nbsp;3️⃣ Using RB0 interrupt with the Auto/Manual button. <br>
&nbsp;&nbsp;4️⃣ Dependency of Auto/Manual switching on the previous mode condition.

> [!IMPORTANT]
> - Download the full repo to run the simulation. <br>
> - Source Code: [Code/Traffic_Light_System.c](./Code/Traffic_Light_System.c) <br>
> - Proteus Simulation: [Circuit/Traffic_Light_System.pdsprj](./Circuit/Traffic_Light_System.pdsprj)

View the simulation test on YouTube: [Click Here](https://www.youtube.com/watch?v=EklaqNCCM_M)
</b>