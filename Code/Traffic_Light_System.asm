
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Traffic_Light_System.c,33 :: 		void interrupt() {
;Traffic_Light_System.c,34 :: 		if(intf_bit) {
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;Traffic_Light_System.c,35 :: 		intf_bit = 0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;Traffic_Light_System.c,36 :: 		flag = (flag == 0? 1:0);
	MOVLW      0
	XORWF      _flag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt63
	MOVLW      0
	XORWF      _flag+0, 0
L__interrupt63:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
	MOVLW      1
	MOVWF      R1+0
	GOTO       L_interrupt2
L_interrupt1:
	CLRF       R1+0
L_interrupt2:
	MOVF       R1+0, 0
	MOVWF      _flag+0
	MOVLW      0
	BTFSC      _flag+0, 7
	MOVLW      255
	MOVWF      _flag+1
;Traffic_Light_System.c,37 :: 		}
L_interrupt0:
;Traffic_Light_System.c,38 :: 		}
L_end_interrupt:
L__interrupt62:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Traffic_Light_System.c,40 :: 		void main() {
;Traffic_Light_System.c,42 :: 		trisb = 3;
	MOVLW      3
	MOVWF      TRISB+0
;Traffic_Light_System.c,43 :: 		trisc = 0;
	CLRF       TRISC+0
;Traffic_Light_System.c,44 :: 		trisd = 0;
	CLRF       TRISD+0
;Traffic_Light_System.c,45 :: 		portb = 0;
	CLRF       PORTB+0
;Traffic_Light_System.c,46 :: 		portc = 0;
	CLRF       PORTC+0
;Traffic_Light_System.c,47 :: 		portd = 8;
	MOVLW      8
	MOVWF      PORTD+0
;Traffic_Light_System.c,49 :: 		gie_bit = 1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;Traffic_Light_System.c,50 :: 		inte_bit = 1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;Traffic_Light_System.c,51 :: 		intedg_bit = 1; // Rising Edge
	BSF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;Traffic_Light_System.c,53 :: 		while(1) {
L_main3:
;Traffic_Light_System.c,55 :: 		if(flag != 1) {
	MOVLW      0
	XORWF      _flag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main65
	MOVLW      1
	XORWF      _flag+0, 0
L__main65:
	BTFSC      STATUS+0, 2
	GOTO       L_main5
;Traffic_Light_System.c,57 :: 		if(S_RED) {
	BTFSS      PORTD+0, 3
	GOTO       L_main6
;Traffic_Light_System.c,58 :: 		for(i = 23; i > 0 && flag != 1; i--) {
	MOVLW      23
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_main7:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main66
	MOVF       _i+0, 0
	SUBLW      0
L__main66:
	BTFSC      STATUS+0, 0
	GOTO       L_main8
	MOVLW      0
	XORWF      _flag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main67
	MOVLW      1
	XORWF      _flag+0, 0
L__main67:
	BTFSC      STATUS+0, 2
	GOTO       L_main8
L__main60:
;Traffic_Light_System.c,59 :: 		W_RED = 0;
	BCF        PORTD+0, 0
;Traffic_Light_System.c,60 :: 		W_YELLOW = (i > 3? 0:1);
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main68
	MOVF       _i+0, 0
	SUBLW      3
L__main68:
	BTFSC      STATUS+0, 0
	GOTO       L_main12
	CLRF       R3+0
	GOTO       L_main13
L_main12:
	MOVLW      1
	MOVWF      R3+0
L_main13:
	BTFSC      R3+0, 0
	GOTO       L__main69
	BCF        PORTD+0, 1
	GOTO       L__main70
L__main69:
	BSF        PORTD+0, 1
L__main70:
;Traffic_Light_System.c,61 :: 		W_GREEN = (i > 3? 1:0);
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main71
	MOVF       _i+0, 0
	SUBLW      3
L__main71:
	BTFSC      STATUS+0, 0
	GOTO       L_main14
	MOVLW      1
	MOVWF      R4+0
	GOTO       L_main15
L_main14:
	CLRF       R4+0
L_main15:
	BTFSC      R4+0, 0
	GOTO       L__main72
	BCF        PORTD+0, 2
	GOTO       L__main73
L__main72:
	BSF        PORTD+0, 2
L__main73:
;Traffic_Light_System.c,62 :: 		S_YELLOW = 0;
	BCF        PORTD+0, 4
;Traffic_Light_System.c,63 :: 		S_GREEN = 0;
	BCF        PORTD+0, 5
;Traffic_Light_System.c,64 :: 		Countdown = segment[i];
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Traffic_Light_System.c,65 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main16:
	DECFSZ     R13+0, 1
	GOTO       L_main16
	DECFSZ     R12+0, 1
	GOTO       L_main16
	DECFSZ     R11+0, 1
	GOTO       L_main16
	NOP
	NOP
;Traffic_Light_System.c,58 :: 		for(i = 23; i > 0 && flag != 1; i--) {
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;Traffic_Light_System.c,66 :: 		}
	GOTO       L_main7
L_main8:
;Traffic_Light_System.c,67 :: 		if(flag != 1) S_RED = 0;
	MOVLW      0
	XORWF      _flag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main74
	MOVLW      1
	XORWF      _flag+0, 0
L__main74:
	BTFSC      STATUS+0, 2
	GOTO       L_main17
	BCF        PORTD+0, 3
L_main17:
;Traffic_Light_System.c,68 :: 		}
	GOTO       L_main18
L_main6:
;Traffic_Light_System.c,72 :: 		for(i = 15; i > 0 && flag != 1; i--) {
	MOVLW      15
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_main19:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main75
	MOVF       _i+0, 0
	SUBLW      0
L__main75:
	BTFSC      STATUS+0, 0
	GOTO       L_main20
	MOVLW      0
	XORWF      _flag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main76
	MOVLW      1
	XORWF      _flag+0, 0
L__main76:
	BTFSC      STATUS+0, 2
	GOTO       L_main20
L__main59:
;Traffic_Light_System.c,73 :: 		W_RED = 1;
	BSF        PORTD+0, 0
;Traffic_Light_System.c,74 :: 		W_YELLOW = 0;
	BCF        PORTD+0, 1
;Traffic_Light_System.c,75 :: 		W_GREEN = 0;
	BCF        PORTD+0, 2
;Traffic_Light_System.c,76 :: 		S_YELLOW = (i > 3? 0:1);
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main77
	MOVF       _i+0, 0
	SUBLW      3
L__main77:
	BTFSC      STATUS+0, 0
	GOTO       L_main24
	CLRF       R5+0
	GOTO       L_main25
L_main24:
	MOVLW      1
	MOVWF      R5+0
L_main25:
	BTFSC      R5+0, 0
	GOTO       L__main78
	BCF        PORTD+0, 4
	GOTO       L__main79
L__main78:
	BSF        PORTD+0, 4
L__main79:
;Traffic_Light_System.c,77 :: 		S_GREEN = (i > 3? 1:0);
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main80
	MOVF       _i+0, 0
	SUBLW      3
L__main80:
	BTFSC      STATUS+0, 0
	GOTO       L_main26
	MOVLW      1
	MOVWF      R6+0
	GOTO       L_main27
L_main26:
	CLRF       R6+0
L_main27:
	BTFSC      R6+0, 0
	GOTO       L__main81
	BCF        PORTD+0, 5
	GOTO       L__main82
L__main81:
	BSF        PORTD+0, 5
L__main82:
;Traffic_Light_System.c,78 :: 		Countdown = segment[i];
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Traffic_Light_System.c,79 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main28:
	DECFSZ     R13+0, 1
	GOTO       L_main28
	DECFSZ     R12+0, 1
	GOTO       L_main28
	DECFSZ     R11+0, 1
	GOTO       L_main28
	NOP
	NOP
;Traffic_Light_System.c,72 :: 		for(i = 15; i > 0 && flag != 1; i--) {
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;Traffic_Light_System.c,80 :: 		}
	GOTO       L_main19
L_main20:
;Traffic_Light_System.c,81 :: 		if(flag != 1) S_RED = 1;
	MOVLW      0
	XORWF      _flag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main83
	MOVLW      1
	XORWF      _flag+0, 0
L__main83:
	BTFSC      STATUS+0, 2
	GOTO       L_main29
	BSF        PORTD+0, 3
L_main29:
;Traffic_Light_System.c,82 :: 		}
L_main18:
;Traffic_Light_System.c,83 :: 		}
	GOTO       L_main30
L_main5:
;Traffic_Light_System.c,88 :: 		if(S_RED){
	BTFSS      PORTD+0, 3
	GOTO       L_main31
;Traffic_Light_System.c,89 :: 		for(i = 3; i > 0 && flag; i--) {
	MOVLW      3
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_main32:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main84
	MOVF       _i+0, 0
	SUBLW      0
L__main84:
	BTFSC      STATUS+0, 0
	GOTO       L_main33
	MOVF       _flag+0, 0
	IORWF      _flag+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main33
L__main58:
;Traffic_Light_System.c,90 :: 		W_YELLOW = 1;
	BSF        PORTD+0, 1
;Traffic_Light_System.c,91 :: 		W_GREEN = 0;
	BCF        PORTD+0, 2
;Traffic_Light_System.c,92 :: 		Countdown = segment[i];
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Traffic_Light_System.c,93 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main37:
	DECFSZ     R13+0, 1
	GOTO       L_main37
	DECFSZ     R12+0, 1
	GOTO       L_main37
	DECFSZ     R11+0, 1
	GOTO       L_main37
	NOP
	NOP
;Traffic_Light_System.c,89 :: 		for(i = 3; i > 0 && flag; i--) {
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;Traffic_Light_System.c,94 :: 		}
	GOTO       L_main32
L_main33:
;Traffic_Light_System.c,95 :: 		while(flag && Manual != 1) {
L_main38:
	MOVF       _flag+0, 0
	IORWF      _flag+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main39
	BTFSC      PORTB+0, 1
	GOTO       L_main39
L__main57:
;Traffic_Light_System.c,96 :: 		W_RED = 1;
	BSF        PORTD+0, 0
;Traffic_Light_System.c,97 :: 		W_YELLOW = 0;
	BCF        PORTD+0, 1
;Traffic_Light_System.c,98 :: 		S_RED = 0;
	BCF        PORTD+0, 3
;Traffic_Light_System.c,99 :: 		S_GREEN = 1;
	BSF        PORTD+0, 5
;Traffic_Light_System.c,100 :: 		Countdown = segment[0];
	MOVF       _segment+0, 0
	MOVWF      PORTC+0
;Traffic_Light_System.c,101 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main42:
	DECFSZ     R13+0, 1
	GOTO       L_main42
	DECFSZ     R12+0, 1
	GOTO       L_main42
	NOP
	NOP
;Traffic_Light_System.c,102 :: 		}
	GOTO       L_main38
L_main39:
;Traffic_Light_System.c,103 :: 		}
	GOTO       L_main43
L_main31:
;Traffic_Light_System.c,106 :: 		for(i = 3; i > 0 && flag; i--) {
	MOVLW      3
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_main44:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main85
	MOVF       _i+0, 0
	SUBLW      0
L__main85:
	BTFSC      STATUS+0, 0
	GOTO       L_main45
	MOVF       _flag+0, 0
	IORWF      _flag+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main45
L__main56:
;Traffic_Light_System.c,107 :: 		S_YELLOW = 1;
	BSF        PORTD+0, 4
;Traffic_Light_System.c,108 :: 		S_GREEN = 0;
	BCF        PORTD+0, 5
;Traffic_Light_System.c,109 :: 		Countdown = segment[i];
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Traffic_Light_System.c,110 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main49:
	DECFSZ     R13+0, 1
	GOTO       L_main49
	DECFSZ     R12+0, 1
	GOTO       L_main49
	DECFSZ     R11+0, 1
	GOTO       L_main49
	NOP
	NOP
;Traffic_Light_System.c,106 :: 		for(i = 3; i > 0 && flag; i--) {
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;Traffic_Light_System.c,111 :: 		}
	GOTO       L_main44
L_main45:
;Traffic_Light_System.c,112 :: 		while(flag && Manual != 1) {
L_main50:
	MOVF       _flag+0, 0
	IORWF      _flag+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main51
	BTFSC      PORTB+0, 1
	GOTO       L_main51
L__main55:
;Traffic_Light_System.c,113 :: 		W_RED = 0;
	BCF        PORTD+0, 0
;Traffic_Light_System.c,114 :: 		W_GREEN = 1;
	BSF        PORTD+0, 2
;Traffic_Light_System.c,115 :: 		S_RED = 1;
	BSF        PORTD+0, 3
;Traffic_Light_System.c,116 :: 		S_YELLOW = 0;
	BCF        PORTD+0, 4
;Traffic_Light_System.c,117 :: 		Countdown = segment[0];
	MOVF       _segment+0, 0
	MOVWF      PORTC+0
;Traffic_Light_System.c,118 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main54:
	DECFSZ     R13+0, 1
	GOTO       L_main54
	DECFSZ     R12+0, 1
	GOTO       L_main54
	NOP
	NOP
;Traffic_Light_System.c,119 :: 		}
	GOTO       L_main50
L_main51:
;Traffic_Light_System.c,120 :: 		}
L_main43:
;Traffic_Light_System.c,121 :: 		}
L_main30:
;Traffic_Light_System.c,122 :: 		}
	GOTO       L_main3
;Traffic_Light_System.c,123 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
