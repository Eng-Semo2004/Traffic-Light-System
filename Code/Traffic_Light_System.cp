#line 1 "D:/SFE/2nd Communications/Summer Training/Embedded Systems/Traffic_Light_System/Project/Code/Traffic_Light_System.c"
#line 27 "D:/SFE/2nd Communications/Summer Training/Embedded Systems/Traffic_Light_System/Project/Code/Traffic_Light_System.c"
int segment[] = {0x00, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49,
 0xD0, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9,
 0xE0, 0xE1, 0xE2, 0xE3};
int i, flag = 0;


void interrupt() {
 if(intf_bit) {
 intf_bit = 0;
 flag = (flag == 0? 1:0);
 }
}

void main() {

 trisb = 3;
 trisc = 0;
 trisd = 0;
 portb = 0;
 portc = 0;
 portd = 8;

 gie_bit = 1;
 inte_bit = 1;
 intedg_bit = 1;

 while(1) {

 if(flag != 1) {

 if( portd.b3 ) {
 for(i = 23; i > 0 && flag != 1; i--) {
  portd.b0  = 0;
  portd.b1  = (i > 3? 0:1);
  portd.b2  = (i > 3? 1:0);
  portd.b4  = 0;
  portd.b5  = 0;
  portc  = segment[i];
 delay_ms(1000);
 }
 if(flag != 1)  portd.b3  = 0;
 }


 else {
 for(i = 15; i > 0 && flag != 1; i--) {
  portd.b0  = 1;
  portd.b1  = 0;
  portd.b2  = 0;
  portd.b4  = (i > 3? 0:1);
  portd.b5  = (i > 3? 1:0);
  portc  = segment[i];
 delay_ms(1000);
 }
 if(flag != 1)  portd.b3  = 1;
 }
 }


 else {

 if( portd.b3 ){
 for(i = 3; i > 0 && flag; i--) {
  portd.b1  = 1;
  portd.b2  = 0;
  portc  = segment[i];
 delay_ms(1000);
 }
 while(flag &&  portb.b1  != 1) {
  portd.b0  = 1;
  portd.b1  = 0;
  portd.b3  = 0;
  portd.b5  = 1;
  portc  = segment[0];
 delay_ms(50);
 }
 }

 else {
 for(i = 3; i > 0 && flag; i--) {
  portd.b4  = 1;
  portd.b5  = 0;
  portc  = segment[i];
 delay_ms(1000);
 }
 while(flag &&  portb.b1  != 1) {
  portd.b0  = 0;
  portd.b2  = 1;
  portd.b3  = 1;
  portd.b4  = 0;
  portc  = segment[0];
 delay_ms(50);
 }
 }
 }
 }
}
