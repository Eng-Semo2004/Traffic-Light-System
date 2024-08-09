/*
  Name: Traffic_Light.c
  Author: Islam Ahmed Nabil Asar
  Date: Aug 05, 2024
  ____________________________________________________________________

  This project is about an automatic traffic light system between two
  streets: West St. (15s Red, 3s Yellow, 20s Green) and South St.
  (23s Red, 3s Yellow, 12s Green). The system has two buttons:
  one for Auto/Manual, and one for switching between 2 streets
  in Manual mode.
*/

// Switches
#define Manual portb.b1

// Traffic Lights
#define W_RED portd.b0
#define W_YELLOW portd.b1
#define W_GREEN portd.b2
#define S_RED portd.b3
#define S_YELLOW portd.b4
#define S_GREEN portd.b5

// 7seg Display
#define Countdown portc
int segment[] = {0x00, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49,
                 0xD0, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9,
                 0xE0, 0xE1, 0xE2, 0xE3};
int i, flag = 0;

// Auto/Manual button interrupt
void interrupt() {
     if(intf_bit) {
          intf_bit = 0;
          flag = (flag == 0? 1:0);
     }
}

void main() {
  // Setting up the pins
  trisb = 3;
  trisc = 0;
  trisd = 0;
  portb = 0;
  portc = 0;
  portd = 8;
  // Enabling the interrupt RB0
  gie_bit = 1;
  inte_bit = 1;
  intedg_bit = 1; // Rising Edge

  while(1) {
    // Auto Mode
    if(flag != 1) {
      // West St.: GO, South St.: STOP
      if(S_RED) {
        for(i = 23; i > 0 && flag != 1; i--) {
          W_RED = 0;
          W_YELLOW = (i > 3? 0:1);
          W_GREEN = (i > 3? 1:0);
          S_YELLOW = 0;
          S_GREEN = 0;
          Countdown = segment[i];
          delay_ms(1000);
        }
        if(flag != 1) S_RED = 0;
      }

      // West St.: STOP, South St.: GO
      else {
        for(i = 15; i > 0 && flag != 1; i--) {
          W_RED = 1;
          W_YELLOW = 0;
          W_GREEN = 0;
          S_YELLOW = (i > 3? 0:1);
          S_GREEN = (i > 3? 1:0);
          Countdown = segment[i];
          delay_ms(1000);
        }
        if(flag != 1) S_RED = 1;
      }
    }

    // Manual Mode
    else {
      // Using S_RED to switch between the 2 streets
      if(S_RED){
        for(i = 3; i > 0 && flag; i--) {
          W_YELLOW = 1;
          W_GREEN = 0;
          Countdown = segment[i];
          delay_ms(1000);
        }
        while(flag && Manual != 1) {
          W_RED = 1;
          W_YELLOW = 0;
          S_RED = 0;
          S_GREEN = 1;
          Countdown = segment[0];
          delay_ms(50);
        }
      }

      else {
        for(i = 3; i > 0 && flag; i--) {
          S_YELLOW = 1;
          S_GREEN = 0;
          Countdown = segment[i];
          delay_ms(1000);
        }
        while(flag && Manual != 1) {
          W_RED = 0;
          W_GREEN = 1;
          S_RED = 1;
          S_YELLOW = 0;
          Countdown = segment[0];
          delay_ms(50);
        }
      }
    }
  }
}