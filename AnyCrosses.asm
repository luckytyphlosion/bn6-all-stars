 ; MegaMan Battle Network 6: Cybeast Gregar/Falzar (U)
 ; Any Crosses Hack v2.0b
 ; Change the 5 Crosses in your Custom Screen with flags or NCPs.
 ; By Prof. 9
 ; Made for ARMIPS assembler v0.7c

input		equ input.gba
fspace		equ 0x087FE36C
version		equ 1		; 0 = Gregar, 1 = Falzar

NCPeffect	equ 0xC8
set2flag	equ 0x0000

.macro data



crosses:	; Cross1,Cross2,Cross3,Cross4,Cross5,Beast
dcb 0x06,0x07,0x08,0x09,0x0A,0x0C
dcb 0x01,0x02,0x03,0x04,0x05,0x0B

windowmugs:	; selection window button graphics
dcd	0x086E7DCC
dcd	0x086E7DCC

windowpals:	; selection window button palettes
dcd	0x086E944C
dcd	0x086E944C

beastbutton:
; Button graphics, Chip Image, Chip Palette, Sound Effect
dcd	0x086E79CC,0x08723034,0x08725814,0x193
dcd	0x086E79CC,0x08723034,0x08725814,0x193



.endmacro

.gba
.open input,output.gba,8000000h

.org fspace
.align 2
extra1:
push	r5
push	r14
mov	r6,r0
bl	getset
ldrb	r6,[r1,r6]
pop	r15

extra2:
push	r14
bl	getset
ldrb	r0,[r5,1Ah]
ldrb	r0,[r1,r0]
add	r0,r0,r4
mov	r1,0h
ldr	r3,=8015953h
mov	r14,r15
bx	r3
sub	r0,r0,r4
pop	r15

extra3:
push	r14
mov	r4,0h
cmp	r0,1h
beq	extra3a
cmp	r1,0h
beq	extra3b
add	r1,0Ch
mov	r4,r1
b	extra3c
extra3a:
mov	r4,0Ch
extra3b:
bl	getset
ldrb	r0,[r1,5h]
add	r4,r0,r4
extra3c:
pop	r15

extra4:
bl	extra4b
ldr	r1,=8029EE9h+version*2
bx	r1

extra4a:
ldr	r3,=20349A0h
bl	extra4b
ldr	r1,=8029F17h+version*4
bx	r1

extra4b:
push	r14
bl	getset
ldrb	r1,[r1,r4]
sub	r1,1h
mov	r0,1h
lsl	r0,r1
ldr	r3,[r3]
and	r3,r0
pop	r15

extra5:
ldr	r3,=windowmugs
bl	getptr
ldr	r1,=8029DADh
bx	r1

extra6:
ldr	r3,=windowpals
bl	getptr
ldr	r1,=8029EB7h
bx	r1

extra7:
push	r0
bl	getset
ldrb	r0,[r5,1Bh]
add	r2,r2,r0
ldrb	r0,[r5,r2]
ldrb	r1,[r1,r0]
sub	r1,1h
pop	r0
ldr	r2,=8028B55h
bx	r2

extra8:
push	r14
mov	r2,0h
bl	getbst
ldr	r2,=80282B3h
bx	r2

extra9:
mov	r2,4h
bl	getbst
ldr	r1,=6009560h
ldr	r2,=8028727h
bx	r2

extra10:
mov	r2,8h
bl	getbst
add	r0,r0,r1
ldr	r1,=802873Dh
bx	r1

extra11:
mov	r2,r15
add	r2,7h
mov	r14,r2
ldr	r2,=80302B7h
bx	r2
mov	r2,0Ch
bl	getbst
ldr	r1,=80005CDh
mov	r14,r15
bx	r1
ldr	r0,=802776Bh
bx	r0

getptr:		; input: r3 = pointer list start, output: r0 = required pointer
push	r0,r1,r3,r14
bl	getset
lsl	r0,r0,2h
ldr	r3,[r3,r0]
pop	r0,r1
add	r0,r0,r3
pop	r3,r15

getbst:		; input: r2 = pointer number * 4, output: r0 = beastbutton
push	r1,r14
bl	getset
lsl	r0,r0,4h
ldr	r1,=beastbutton
add	r0,r1,r0
ldr	r0,[r0,r2]
pop	r1,r15

getset:		; output: r0 = set value, r1 = set offset
.if (set2flag != 0) | (NCPeffect != 0)
push	r3,r14
.endif

checkflag:
.if set2flag != 0
mov	r0,set2flag >> 8
mov	r1,set2flag & 0xFF
mov	r3,r15
add	r3,7h
mov	r14,r3
ldr	r3,=802F165h
bx	r3
beq	checkNCPeffect
mov	r0,1h
b	getsetend
.endif

checkNCPeffect:
.if NCPeffect != 0
mov	r3,r15
add	r3,7h
mov	r14,r3
ldr	r3,=80010B7h
bx	r3
mov	r1,NCPeffect
ldr	r3,=80137B7h
mov	r14,r15
bx	r3
.else
mov	r0,0h
.endif

getsetend:
.if (set2flag != 0) | (NCPeffect != 0)
mov	r1,6h
mul	r1,r0
.endif
ldr	r3,=crosses
.if (set2flag != 0) | (NCPeffect != 0)
add	r1,r1,r3
.endif
.if (set2flag != 0) | (NCPeffect != 0)
pop	r3,r15
.else
bx	r14
.endif

.pool

data

.org 0x0802A086+version*4
ldr	r6,=extra1|1b
mov	r14,r15
bx	r6
.org 0x0802A0DC+version*4
.pool

.org 0x0802937C
mov	r4,0h
.org 0x08029386
mov	r4,0Ch
.org 0x08029390
ldr	r1,=extra2|1b
mov	r14,r15
bx	r1
b	80293A0h
.pool

.org 0x08029352
ldr	r4,=extra3|1b
mov	r14,r15
bx	r4
b	8029368h
.pool

.org 0x08029EE0
ldr	r0,=extra4|1b
bx	r0
.pool

.org 0x08029F0C+version*2
ldr	r0,=extra4a|1b
bx	r0
.pool

.org 0x08029DA8
ldr	r1,=extra5|1b
bx	r1
.org 0x08029DD8
.pool

.org 0x08029EB2
ldr	r1,=extra6|1b
bx	r1
.org 0x08029EC0
.pool

.org 0x08028B4A
ldr	r2,[8028B6Ch]
ldr	r1,=extra7|1b
bx	r1
.pool

.org 0x08028378
dcd	extra8|1b

.org 0x08028722
ldr	r0,=extra9|1b
bx	r0
.org 0x0802874C
.pool

.org 0x08028738
ldr	r0,=extra10|1b
bx	r0
.org 0x08028750
.pool

.org 0x0802775E
ldr	r2,=extra11|1b
bx	r2
.org 0x08027764
.pool

.close
; eof