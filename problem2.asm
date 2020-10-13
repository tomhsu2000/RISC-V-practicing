.globl main
.data
	output:	.string"output : \n"
	space:	.string" "
.text
#  global reg
# a2 = N
# a3 = M
# a4 = number[]
# a5 = i
# a6 = j
# s1 = return value
main:
	li a7, 5
	ecall
	add a2, a0, zero
	li a7, 5
	ecall
	add a3, a0, zero
	# number[] = new int[N]
	slli t1, a2, 3
	sub sp, sp, t1
	add a4, sp, zero
	add t1, zero, zero
# cin loop start
cin_loop:
	bge t1, a2, cin_exit
	slli t2, t1, 3
	add t2, t2, a4
	li a7, 5
	ecall
	add t3, a0, zero
	sw t3, 0(t2)
	addi t1, t1, 1
	beq zero, zero, cin_loop
# cin loop end
cin_exit:
	jal ra, bobule_sort
	la a0, output
	li a7, 4
	ecall
	add t1, zero, zero
# cout loop start
cout_loop:
	bge t1, a2, cout_exit
	slli t2, t1, 3
	add t2, t2, a4
	lw t3, 0(t2)
	add a0, t3, zero
	li a7, 1
	ecall
	la a0, space
	li a7, 4
	ecall
	addi t1, t1, 1
	beq zero, zero, cout_loop
# cout loop end
cout_exit:
	# delete[]number
	slli t1, a2, 3
	add sp, sp, t1
	add a4, zero, zero
	beq zero, zero, end
# main end
end:
	li a7, 10
	ecall
#bobule sort number[]
bobule_sort:
	# save return address
	addi sp, sp, -8
	sw ra, 0(sp)
	# t1 = i = N - 1
	add t1, zero, zero
	addi t2, a2, -1
# sort loop for i start
sort_loop_1:
	bge t1, t2, sort_exit_1
	# t3 = j = i + 1
	addi t3, t1, 1
# sort loop for j start
sort_loop_2:
	bge t3, a2, srot_exit_2
	add a5, t1, zero
	add a6, t3, zero
	# save temp
	addi sp, sp, -24
	sw t1, 16(sp)
	sw t2, 8(sp)
	sw t3, 0(sp)
	jal ra, cmp
	beq s1, zero, exit_if
	jal ra, swap
# exit if statment
exit_if:
	# load temp
	lw t1, 16(sp)
	lw t2, 8(sp)
	lw t3, 0(sp)
	addi sp, sp, 24
	addi t3, t3, 1
	beq zero, zero, sort_loop_2
# sort loop for j end
srot_exit_2:
	addi t1, t1, 1
	beq zero, zero, sort_loop_1
# sort loop for i end
sort_exit_1:
	# load return address
	lw ra, 0(sp)
	addi sp, sp, 8
	jalr zero, ra, 0
# compare number[i] & number[j]
cmp:
	# t1 = number[i]
	slli t1, a5, 3
	add t1, t1, a4
	lw t1, 0(t1)
	# t3 = number[j]
	slli t3, a6, 3
	add t3, t3, a4
	lw t3, 0(t3)
	# t2 = number[i] % M
	div t2, t1, a3
	mul t2, t2, a3
	sub t2, t1, t2
	# t4 = number[j] % M
	div t4, t3, a3
	mul t4, t4, a3
	sub t4, t3, t4
	beq t2, t4, cmp_mod_eq
	blt t2, t4, cmp_false
	beq zero, zero, cmp_true
# number[i] & number[j] % M are equal
cmp_mod_eq:
	addi t5, zero, 2
	# t2 = number[i] % 2
	div t2, t1, t5
	mul t2, t2, t5
	sub t2, t1, t2
	# t4 = number[j] % 2
	div t4, t3, t5
	mul t4, t4, t5
	sub t4, t3, t4
	beq t2, t4, cmp_mod2_eq
	blt t2, t4, cmp_true
	beq zero, zero, cmp_false
# number[i] & number[j] % 2 are equal
cmp_mod2_eq:
	beq t2, zero, cmp_even
	blt t1, t3, cmp_true
	beq zero, zero, cmp_false
# number[i] & number[j] are even
cmp_even:
	blt t1, t3, cmp_false
	beq zero, zero, cmp_true
# return true
cmp_true:
	addi s1, zero, 1
	jalr zero, ra, 0
# return false
cmp_false:
	addi s1, zero, 0
	jalr zero, ra, 0
# swap number[i] & number[j]
swap:
	slli t1, a5, 3
	add t1, t1, a4
	lw t2, 0(t1)
	slli t3, a6, 3
	add t3, t3, a4
	lw t4, 0(t3)
	sw t4, 0(t1)
	sw t2, 0(t3)
	jalr zero, ra, 0
