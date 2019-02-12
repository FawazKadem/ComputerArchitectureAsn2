		AREA algebra, CODE, READWRITE
		ENTRY
		
		LDR r0,	X;				store the value of x
		LDR r13, =opStack;		load the stack into r13 to be used later
		BL cal
endless B endless
		
cal		STMFD r13!, {r2-r7}
		LDR r2, A;				loading all the vlalues
		LDR r3, B;
		LDR r4, C;
		LDR r5, D;
		LDR r6, X;
		LDR r7, ZERO;
		
		MUL r7, r6, r2;			getting a times x
		ADD r7, r7, r3;			getting a times x plus b
		MOV r0, r7;				since you can't multiply a register by itself without a warning this was necessary
		MUL r7, r0, r6;			getting a times x plus b all of that times x 
		ADD r7, r7, r4;			getting a times x plus b all of that times x plus c
		
		CMP r7, r5;				to see what is bigger d or the final algebra value
		BGT big;				if d is smaller then you go to big
		MOV r0, r7;				set the final algebra value to r0 because the other registers will be cleared
		LDMFD r13!, {r2-r7};	clear the stack
		MOV r1, r0, LSL #1; 	since r1 is suppose to have twice the value of r0	
		MOV	PC, r14;			
				
big		MOV r0, r5;
		LDMFD r13!, {r2-r7} ; restore temp variable from stack
		MOV r1, r0, LSL #1;
		MOV	PC, r14
		
		AREA algebra, DATA, READWRITE
ZERO	DCD 0;
X		DCD	3;
A		DCD 5;		
B		DCD	6;
C		DCD 7;
D		DCD	90;
		SPACE 30;		
opStack	DCD 0x00;
		END