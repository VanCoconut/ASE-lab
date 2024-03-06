.data

v1:	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8

v2:	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8

v3: 	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8

v4:	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8
	.double 1, 2, 3, 4, 5, 6, 7, 8

v5:	.space 512
v6:	.space 512
v7:	.space 512

.code

main:	daddui r10, r0, 64
	daddui r1,r0,0

loop: 	l.d f1, v1(r1)
	l.d f2, v2(r1)
	l.d f3, v3(r1)
	l.d f4, v4(r1)	

	mul.d f11,f1,f2

	add.d f12,f3,f4

	add.d f13,f4,f1

	add.d f14,f2,f3

	add.d f5,f11,f12

	div.d f6,f5,f13	

	s.d F5, v5(r1)

	daddi r10, r10, -1	

	s.d F6, v6(r1)	
	
	mul.d f7,f6,f14	

	s.d F7, v7(r1)

	daddi r1, r1, 8	

	bnez r10, loop	
	
	nop

done: halt
	
	









