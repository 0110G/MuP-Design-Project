#make_bin#

#LOAD_SEGMENT=FFFFh#
#LOAD_OFFSET=0000h#

#CS=0000h#
#IP=0000h#

#DS=0000h#
#ES=0000h#

#SS=0000h#
#SP=FFFEh#

#AX=0000h#
#BX=0000h#
#CX=0000h#
#DX=0000h#
#SI=0000h#
#DI=0000h#
#BP=0000h#

	jmp st1
	db 509 dup(0)
	dw rst			
	dw 0000
	db 508 dup(0)
	
	;Plan:
	;Choose D1,D2 or D3
	
	
st1:	cli
	mov		  ax,0200h
	mov       ds,ax
    mov       es,ax
    mov       ss,ax
    mov       sp,0FFFEH
	
	drinkip equ 0002h
	sizeip equ 0003h
	drink1no equ 0004h
	drink2no equ 0005h
	drink3no equ 0006h
	rst_status equ 0007h
	
	mov al, 11111111b
	mov rst_status,al
	
	;Initialize 8255(1) 
	;Address Space of 8255(1) : 00h - 06h
	mov al, 10010000b									;Setting PortA as Input, PortB, PortC as output
	out 06h,al
	mov al,[rst_status]
	out 04h,al
	out 02h,al
	;mov al,00h
	;out 02h,al
		
	;Initializing the number of drinks	
	mov al,10
	mov [drink1no],al
	mov al,10
	mov [drink2no],al
	mov al,10
	mov [drink3no],al
		
	;Initialize 8259 INT0
	;Address Space of 8259 : 30h-32h
	sti
	mov al,00010011b
	out 30h,al
	mov al,80h
	out 32h,al
	mov al, 03h
	out 32h,al
	mov al,0FEh
	out 32h,al	
		
		
	;Wait for press of D1,D2 or D3
x1:	;mov al,[rst_status]

	mov al,0ffh
	out 04h,al
	out 02h,al

	in al,00h
	mov bl,al
	not al
	and al,00000111b
	jz x1 

	;Once any of D1,D2 or D3 pressed, and storing it in drinkip and lighting corresponding LEDs 
	mov al,bl
	mov drinkip,al
	out 04h,al
	
	;Once Any of D1-D3 pressed, activate a clock to measure a state of idleness 
	;Initializing Counter0 of 8253 to count 15s
	;Address Space of 8253(2) : 40h-46h, Clock Frequency C0 : 1Hz 
	mov al,00110000b
	out 46h,al
	mov al,0Ah
	out 40h,al
	mov al,00h
	out 40h,al
	

	;mov al, 11111111b
	;out 04h,al
	
	mov cl,1
	
	;Wait for presssing of S,M,L
x3:	cmp cl,1
	jne x1
	in al,00h
	mov bl,al
	not al
	and al, 000111000b
	jz x3
	
	;Once S,M,L pressed, storing it in sizeip and lighting corresponding LEDs
	mov al,bl
	mov sizeip,al
	mov bl,[drinkip]
	and al,bl
	mov rst_status,al
	out 04h,al
	
	;Adding Extra TimeFrame of 10s for Inserting coins
	;mov al,00110110b
	;out 26h,al
	;mov al,0f4h
	;out 20h,al
	;mov al,01h
	;out 20h,al
	
sml1:		mov al,[sizeip]
			not al
			and al,00001000b
			jz med1
		
			
			mov al,[drinkip]
			not al
			and al,11111110b
			jnz x1sd2
			
			mov al,[drink1no]
			cmp al,1
			jge oot
			
			mov al, 11111110b									;Setting PortA as Input, PortB, PortC as output
				out 02h,al
			;glow insufficient drink1
				mov cx,1000
q1:				dec cx
				jnz q1
				
				
			
			jmp x1
			

x1sd2:		mov al,[drinkip]
			not al
			and al,11111101b
			jnz x1sd3	
			
			mov al,[drink2no]
			cmp al,1
			jge oot
			;glow insufficient drink2
				mov al,11111101b
				out 02h,al
				
				
				mov cx,1000
q2:				dec cx
				jnz q2
				

				
			jmp x1

	
x1sd3:
			mov al,[drink3no]
			cmp al,1
			jge oot
			;glow insufficient drink3
			mov al, 11111011b									;Setting PortA as Input, PortB, PortC as output
			out 02h,al
			
			mov cx,1000
q3:			dec cx
			jnz q3
			
			jmp x1

	
med1:	mov al,[sizeip]
		not al
		and al,00010000b
		jz lrg1
		
			mov al,[drinkip]
			not al
			and al,11111110b
			jnz x1md2
			
			mov al,[drink1no]
			cmp al,2
			jge oot
			;glow insufficient drink1
			mov al, 11111110b									;Setting PortA as Input, PortB, PortC as output
				out 02h,al
			;glow insufficient drink1
				mov cx,1000
q4:				dec cx
				jnz q4
			
			jmp x1
	
x1md2:		mov al,[drinkip]
			not al
			and al,11111101b
			jnz x1md3
			
			mov al,[drink2no]
			cmp al,2
			jge oot
			;glow insufficient drink2
			mov al, 11111101b									;Setting PortA as Input, PortB, PortC as output
				out 02h,al
			;glow insufficient drink1
				mov cx,1000
q5:				dec cx
				jnz q5
			jmp x1
x1md3:

			mov al,[drink3no]
			cmp al,2
			jge oot
			;glow insufficient drink3
			mov al, 11111011b									;Setting PortA as Input, PortB, PortC as output
				out 02h,al
			;glow insufficient drink1
				mov cx,1000
q6:				dec cx
				jnz q6
			jmp x1
	
lrg1:		
			mov al,[drinkip]
			not al
			and al,11111110b
			jnz x1ld2
			
			mov al,[drink1no]
			cmp al,3
			jge oot
			;glow insufficient drink1
			mov al, 11111110b									;Setting PortA as Input, PortB, PortC as output
				out 02h,al
			;glow insufficient drink1
				mov cx,1000
q7:				dec cx
				jnz q7
			jmp x1
			
x1ld2:		mov al,[drinkip]
			not al
			and al,11111101b
			jnz x1ld3
			
			mov al,[drink2no]
			cmp al,3
			jge oot
			;glow insufficient drink2
			mov al, 11111101b									;Setting PortA as Input, PortB, PortC as output
				out 02h,al
			;glow insufficient drink1
				mov cx,1000
q8:				dec cx
				jnz q8
			jmp x1
x1ld3:
			mov al,[drink3no]
			cmp al,3
			jge oot
			;glow insufficient drink3
			mov al, 11111011b									;Setting PortA as Input, PortB, PortC as output
				out 02h,al
			;glow insufficient drink1
				mov cx,1000
q9:				dec cx
				jnz q9
			jmp x1
	
oot:

	;Detecting Dispence Button
x5:	in al,00h
	mov bl,al
	not al
	and al,01000000b
	jz x5
	
	cli
	;Initialize 8255(2) 
	;Address Space : 10h - 16h
	mov al,10011000b
	out 16h,al
	mov al,00h
	out 14h,al
	
	;Small Selected
	mov al,[sizeip]
	not al
	and al,00001000b
	jz x11	
 	
	;9 On PA0-PA7 on 8255(2)
		in al,10h
		cmp al,9
		jne x1
		
		;Correct Till Here
				

		;Switiching on DispenceLED
		;mov al,00001110b
		;out 06h,al
		
		;mov al, 10010000b									;Setting PortA as Input, PortB, PortC as output
		;out 06h,al		
			

		;Drink1Small
		mov al,[drinkip]
		not al
		and al,11111110b
		jnz xsd2
		
		mov al,[drink1no]
		sub al,1
		mov [drink1no],al

		
			;Rotate Motor1 for 1s
				mov al,00110000b
				out 26h,al
				mov al,0Ah
				out 20h,al
				mov al,00h
				out 20h,al
		
		;Switch Dispence
		mov al,00001110b
		out 06h,al
		
			mov cx,10000
del0:		dec cx
			jnz del0
		
		mov al, 10010000b									;Setting PortA as Input, PortB, PortC as output
		out 06h,al
		jmp x1
			
xsd2:	;Drink2Small
	


		mov al,[drinkip]
		not al
		and al,11111101b
		jnz xsd3
		
		;Checking Quantity
		mov al,[drink2no]
		sub al,1
		mov [drink2no],al
				
				;Rotate Motor2 for 1s
				mov al,01110000b
				out 26h,al
				mov al,0Ah
				out 22h,al
				mov al,00h
				out 22h,al
			
			
			;mov cx,50
	;Switch Dispence
		mov al,00001110b
		out 06h,al
		
			mov cx,10000
del1:		dec cx
			jnz del1
		
		mov al, 10010000b									;Setting PortA as Input, PortB, PortC as output
		out 06h,al

			
			jmp x1
			
xsd3:	;Drink3
		
		mov al,[drink3no]
		sub al,1
		mov [drink3no],al
		
			;Rotate Motor3 for 1s
			mov al,10110000b
			out 26h,al
			mov al,0Ah
			out 24h,al
			mov al,00h
			out 24h,al
			
			
x14:	;else

		;Switch Dispence
		mov al,00001110b
		out 06h,al
		
			mov cx,10000
del2:		dec cx
			jnz del2
		
		mov al, 10010000b									;Setting PortA as Input, PortB, PortC as output
		out 06h,al
		jmp x1
	
x11:	;Medium Selected
		mov al,[sizeip]
		not al
		and al,00010000b
		jz x12
		;10011001b On PA0-PA7 on 8255(2)
		
		in al,10h
		cmp al,10011001b
		jne x1
				
		;Switiching on DispenceLED
		;mov al,00001110b
		;out 06h,al
		;Drink1
			mov al,[drinkip]
			not al
			and al,11111110b
			jnz xmd2
		
			mov al,[drink1no]
			sub al,2
			mov [drink1no],al
		
			;Rotate Motor1 for 2s
			mov al,00110000b
			out 26h,al
			mov al,14h
			out 20h,al
			mov al,00h
			out 20h,al
			
			;Switch Dispence
		mov al,00001110b
		out 06h,al
		
			mov cx,10000
del3:		dec cx
			jnz del3
		
		mov al, 10010000b									;Setting PortA as Input, PortB, PortC as output
		out 06h,al
			
			
			jmp x1
		
xmd2:		;Drink2	
			mov al,[drinkip]
			not al
			and al,11111101b
			jnz xmd3
			
					mov al,[drink2no]
		sub al,2
		mov [drink2no],al
			
		;Rotate Motor2 for 2s
			mov al,01110000b
			out 26h,al
			mov al,14h
			out 22h,al
			mov al,00h
			out 22h,al
			
			;Switch Dispence
		mov al,00001110b
		out 06h,al
		
			mov cx,10000
del4:		dec cx
			jnz del4
		
		mov al, 10010000b									;Setting PortA as Input, PortB, PortC as output
		out 06h,al
			
			jmp x1
			
xmd3:		
			mov al,[drink3no]
			sub al,2
			mov [drink3no],al

			;Drink3
			;Rotate Motor3 for 2s
			mov al,10110000b
			out 26h,al
			mov al,14h
			out 24h,al
			mov al,00h
			out 24h,al
		
			;else
			;Switch Dispence
		mov al,00001110b
		out 06h,al
		
			mov cx,10000
del5:		dec cx
			jnz del5
		
		mov al, 10010000b									;Setting PortA as Input, PortB, PortC as output
		out 06h,al
			
			
			jmp x1
		
x12:	;Large Selected
		
	;11000101b On PA0-PA7 on 8255(2)
		in al,10h
		cmp al,11000101b
		jne x1
		
		;Switiching on DispenceLED
		;mov al,00001110b
		;out 06h,al
		;Drink1
		mov al,[drinkip]
		not al
		and al,11111110b
		jnz xld2
			
			mov al,[drink1no]
			sub al,3
			mov [drink1no],al
			
			;Rotate Motor1 for 3s
			mov al,00110000b
			out 26h,al
			mov al,1Eh
			out 20h,al
			mov al,00h
			out 20h,al
			
			;Switch Dispence
		mov al,00001110b
		out 06h,al
		
			mov cx,10000
del6:		dec cx
			jnz del6
		
		mov al, 10010000b									;Setting PortA as Input, PortB, PortC as output
		out 06h,al
			
			jmp x1
			
xld2:	;Drink2
		mov al,[drinkip]
		not al
		and al,11111101b
		jnz xld3
		
			mov al,[drink2no]
			sub al,3
			mov [drink2no],al
		
			;Rotate Motor2 for 3s
			mov al,01110000b
			out 26h,al
			mov al,1Eh
			out 22h,al
			mov al,00h
			out 22h,al
			
			;Switch Dispence
		mov al,00001110b
		out 06h,al
		
			mov cx,10000
del7:		dec cx
			jnz del7
		
		mov al, 10010000b									;Setting PortA as Input, PortB, PortC as output
		out 06h,al
			
			jmp x1
			
xld3:	;Drink3
			
			mov al,[drink3no]
			sub al,3
			mov [drink3no],al
			;Rotate Motor3 for 3s
			mov al,10110000b
			out 26h,al
			mov al,1Eh
			out 24h,al
			mov al,00h
			out 24h,al
		
			;Switch Dispence
		mov al,00001110b
		out 06h,al
		
			mov cx,10000
del8:		dec cx
			jnz del8
		
		mov al, 10010000b									;Setting PortA as Input, PortB, PortC as output
		out 06h,al
		
			;else
			jmp x1

	
x2:	jmp x2 
	
rst:mov al,00h
	out 04h,al
	iret
	
	;mov al,[rst_status]
	;cmp al,01h
	;je x6
	;mov al, 11111111b
	;out 04h,al
;x6:	iret


	


	