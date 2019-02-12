		AREA removeThe, CODE, READWRITE
		ENTRY

		LDR r1, =STRING1;		loads STRING1 to r1
		LDR r2, =STRING2;		loads STRING2 to r2

s1copy	LDRB r3, [r1], #1;		at the beginning load the first word of r1;
		CMP	r3, #0x00;			check to see if end of line reached
		BEQ endOf;				if end of string reached then go to endOf
		CMP r3, #'t';			check is the character is a t
		BEQ secnd
		STRB r3, [r2], #1;		if not a t then store it
		B s1copy;				and go back to copying string1


secnd	LDRB r4, [r1], #1;		load the next word
		CMP r4, #'h';			check to see if the next letter after t is h
		BEQ third;				then go to another check for the third letter
		STRB r3, [r2], #1;		if not then store the letter
		CMP r4, #0x00;			check to see if end of line reached
		BEQ endOf;				if so then go to endOf
		STRB r4, [r2], #1;		store the second letter that was not a h
		B s1copy;				go back to copying the string since there are more characters

third	LDRB r5, [r1], #1;
		CMP r5, #'e';			check to see if the third letter is e
		BEQ four;				if so then go to check the next letter
		STRB r3, [r2], #1;		if not then store the letter
		STRB r4, [r2], #1;		store the second letter that was not a h
		CMP r5, #0x00;			check to see if end of line reached and if so go to endOf
		BEQ endOf;
		STRB r5, [r2], #1;		store the third letter that was not a 
		B s1copy;				go back to copying the string since there are more characters

four	LDRB r6, [r1], #1;
		CMP r6, #32;			if its a space then don't add letters t,h,e corresponding to r3,r4,r5 to string2 or r9
		BEQ s1copy;				go back to copying the string since there are more characters
		CMP r6, #0x00;			check to see if end of line reached and if so then go ot endOf
		BEQ endOf;
		STRB r3, [r2], #1;		store the third letter that was not a 
		STRB r4, [r2], #1;		store the third letter that was not a 
		STRB r5, [r2], #1;		store the third letter that was not a 
		STRB r6, [r2], #1;		store the third letter that was not a 
		B s1copy;				go back to copying the string since there are more characters

endOf	MOV r3, #0x00;
		STRB r3, [r2], #1;		so the new string will be null terminated
		ADD r9, r9, #1;			store new string with the in r2	
endless	B 	endless;

		AREA removeThe, DATA, READWRITE
STRING1 DCB "the, h";		first string
EoS	DCB	0x00;
STRING2 space 0xFF;
		END