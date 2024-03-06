.data

v1:	.double 1, 4, 4, 4, 5, 1, 1, 1
	.double 5, 1, 1, 1, 5, 1, 1, 1
	.double 1, 2, 3, 4, 5, 1, 1, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 9, 7, 3, 4, 4, 4, 4, 4
	.double 5, 6, 7, 8, 4, 5, 6, 7 
	.double 5, 6, 7, 8, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8

v2:	.double 9, 7, 3, 4, 4, 4, 4, 4
	.double 5, 6, 7, 8, 4, 5, 6, 7 
	.double 5, 6, 7, 8, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 4, 4, 4, 5, 1, 1, 1
	.double 5, 1, 1, 1, 5, 1, 1, 1
	.double 1, 4, 4, 4, 5, 1, 1, 1
	.double 5, 1, 1, 1, 5, 1, 1, 1

v3: 	.double 9, 7, 3, 4, 4, 4, 4, 4
	.double 5, 6, 7, 8, 4, 5, 6, 7 
	.double 5, 6, 7, 8, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 4, 4, 4, 5, 1, 1, 1
	.double 5, 1, 1, 1, 5, 1, 1, 1
	.double 1, 4, 4, 4, 5, 1, 1, 1
	.double 5, 1, 1, 1, 5, 1, 1, 1

v4:	.double 5, 6, 7, 8, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 4, 4, 4, 5, 1, 1, 1
	.double 5, 1, 1, 1, 5, 1, 1, 1
	.double 5, 6, 7, 8, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 4, 4, 4, 5, 1, 1, 1
	.double 5, 1, 1, 1, 5, 1, 1, 1

m:	.word 1

v5:	.space 512
v6:	.space 512
v7:	.space 512
k:	.space 8
p:	.space 8

.code

main:	daddui r10, r0, 64		;contatore del for
	daddui r1,r0,0			
	daddui r20,r0,1			;serve solo per shiftare
	l.d f1, v1(r1)
	l.d f2, v2(r1)

loop: 	
	l.d f4, v4(r1)	
	ld  r3, m(r0)

if:
	andi r5,r10,1
	l.d f3, v3(r1)
	beqz r5, even
	l.d f2, v2(r1)
	
odd:	dmul r6, r3, r10
		mtc1 r8, f8
		cvt.d.l f8, f8
		div.d f9,f8,f1
		s.d f9, p(r0)
		dsllv r11, r20, r1
		cvt.l.d f4, f17
		mfc1 r12, f17
		ddiv r13, r12, r11
		mtc1 r13,f15
		cvt.d.l f15, f15
		s.d f15,k(r0)
		j base

even:	dsllv r9, r3, r10
		mtc1 r9,f9
		cvt.d.l f9, f9
		mul.d f15,f9,f1
		s.d f15,p(r0)
		cvt.l.d f15, f17
		mfc1 r11, f17
		sd r11,m(r0)
	
base:	l.d f21,p(r0)

	add.d f12,f3,f4

	l.d f22,k(r0)

	mul.d f11,f21,f2

	add.d f13,f22,f1

	add.d f5,f11,f12

	div.d f6,f5,f13	

	s.d F5, v5(r1)

	daddi r10, r10, -1

	add.d f14,f2,f3	

	s.d F6, v6(r1)	
	
	mul.d f7,f6,f14	

	s.d F7, v7(r1)

	daddi r1, r1, 8	

	bnez r10, loop	

	l.d f1, v1(r1)

done: halt
	
	









