.data

vi: 	.double 1,2,3,4,5,6
	.double 1,2,3,4,5,6
	.double 1,2,3,4,5,6
	.double 1,2,3,4,5,6
	.double 1,2,3,4,5,6

vw: 	.double 1,2,3,4,5,6
	.double 1,2,3,4,5,6
	.double 1,2,3,4,5,6
	.double 1,2,3,4,5,6
	.double 1,2,3,4,5,6


b: 	.double 3.14
exp: 	.word16 2047


y: 	.space 8

.code

main:	daddui r1,r0,0	
	daddui r2, r0,30

loop:	l.d f1,vi(r1)
	l.d f2,vw(r1)

	mul.d f3,f1,f2

	daddui r1,r1,8

	daddui r2,r2,-1

	add.d f4,f4,f3

	bnez r2, loop

add: 	l.d f5,b(r0)
	add.d f6,f4,f5	

cond:	add.d f11,f0,f0
	lh r4,exp(r0)
	mfc1 r3,f6
	dsll r3,r3,1
	dsrl r3,r3,31
	dsrl r3,r3,22
	dsub r5,r3,r4
	s.d f11,y(r0)
	beqz r5,done

holdv:	s.d f6,y(r0)

done: halt



	