.globl main
.text
# a = a2
# b = a3
# output = a4
main:
	li a7, 5
	ecall
	add a2, a0, zero
	li a7, 5
	ecall
	add a3, a0, zero
	jal ra, gcd
	add a0, a4, zero
	li a7, 1
	ecall
	beq zero, zero, End
End:
	li a7, 10
	ecall
# a = t0
# b = t1
# t = t2
gcd:
	add t0, a2, zero
	add t1, a3, zero
while:
	# t = a%b
	div t2, t0, t1
	mul t2, t2, t1
	sub t2, t0, t2
	add t0, t1, zero
	add t1, t2, zero
	bne t2, zero, while
	add a4, t0, zero
	jalr zero, ra, 0
