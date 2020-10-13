.globl main
.data
	output:	.string"output : \n"
	endl:	.string"\n"
	space:	.string" "
.text
#  global reg
# a2 = N
# a3 = M
# a4 = T
# a5 = X
# a6 = map[][]
# s1 = portal[]
# s2 = prtl_size
# s3 = level
main:
	li a7, 5
	ecall
	add a2, a0, zero
	li a7, 5
	ecall
	add a3, a0, zero
	li a7, 5
	ecall
	add a4, a0, zero
	li a7, 5
	ecall
	add a5, a0, zero
	# map[][] = new int[N][N]
	mul t1, a2, a2
	slli t1, t1, 3
	add a0, t1, zero
	li a7, 9
	ecall
	add a6, a0, zero
	# protal[] = new info[M]
	addi t1, zero, 3
	mul t1, t1, a3
	slli t1, t1, 3
	add a0, t1, zero
	li a7, 9
	ecall
	add s1, a0, zero
	add t1, zero, zero
# cin loop start
cin_loop:
	bge t1, a3, cin_exit
	li a7, 5
	ecall
	add t2, a0, zero
	li a7, 5
	ecall
	add t3, a0, zero
	li a7, 5
	ecall
	add t4, a0, zero
	addi t2, t2, -1
	addi t3, t3 -1
	slli t2, t2, 3
	slli t3, t3, 3
	mul t5, t2, a2
	add t5, t5, t3
	add t5, t5 a6
	sw t4, 0(t5)
	mul t5, t3, a2
	add t5, t5, t2
	add t5, t5 a6
	sw t4, 0(t5)
	addi t1, t1, 1
	beq zero, zero, cin_loop
# cin loop end
cin_exit:
	jal ra, min_span_t
	jal ra, min_cst
	la a0, output
	li a7, 4
	ecall
	add a0, s3, zero
	li a7, 1
	ecall
	la a0, endl
	li a7, 4
	ecall
	addi t1, s2, -1
	add a0, t1, zero
	li a7, 1
	ecall
	la a0, endl
	li a7, 4
	ecall
	addi t1, zero, 1
# cout loop start
cout_loop:
	bge t1, s2, cout_exit
	addi t2, zero, 3
	mul t2, t2, t1
	slli t2, t2, 3
	add t2, t2, s1
	lw t3, 0(t2)
	addi t3, t3, 1
	add a0, t3, zero
	li a7, 1
	ecall
	la a0, space
	li a7, 4
	ecall
	lw t3, 8(t2)
	addi t3, t3, 1
	add a0, t3, zero
	li a7, 1
	ecall
	la a0, endl
	li a7, 4
	ecall
	addi t1, t1, 1
	beq zero, zero, cout_loop
# cout loop end
cout_exit:
	# delete[]protal
	add s1, zero, zero
	# delete[][]map
	add a6, zero, zero
	beq zero, zero, end
# main end
end:
	li a7 ,10
	ecall
# minimum spanning tree
# s4 = is_visi[]
# s5 = min_heap[first]
# s6 = min_heap[last]
min_span_t:
	add s2, zero, zero
	# is_visi[] = new int[N]
	slli t1, a2, 3
	add a0, t1, zero
	li a7, 9
	ecall
	add s4, a0, zero
	# min_heap[] = new info[M]
	addi t1, zero, 3
	mul t1, t1, a3
	slli t1, t1, 4
	add a0, t1, zero
	li a7, 9
	ecall
	add s5, a0, zero
	add s6, s5, zero
	# min_heap.push()
	sw zero, 0(s6)
	sw zero, 8(s6)
	sw zero, 16(s6)
	addi s6, s6, 24
	# s7 = curt
	addi t1, zero, 3
	slli t1, t1, 3
	add a0, t1, zero
	li a7, 9
	ecall
	add s7, a0, zero
mst_while:
	# !min_heap.empty()
	beq s6, s5, mst_while_exit
	add t1, s5, zero
	# t2 = min
	addi t2, zero, 999
find_min:
	beq t1, s6, exit_find
	lw t3, 16(t1)
	bge t3, t2, no_swap
	add t2, t3, zero
	# t4 = min_heap[min]
	add t4, t1, zero
no_swap:
	addi t1, t1, 24
	beq zero, zero, find_min
exit_find:
	# s7 = min_heap.top()
	lw t5, 0(t4)
	sw t5, 0(s7)
	lw t5, 8(t4)
	sw t5, 8(s7)
	lw t5, 16(t4)
	sw t5, 16(s7)
	# min_heap.pop()
	addi s6, s6, -24
	beq t4, s6, no_erase
	lw t1, 0(s6)
	sw t1, 0(t4)
	lw t1, 8(s6)
	sw t1, 8(t4)
	lw t1, 16(s6)
	sw t1, 16(t4)
no_erase:
	# t1 = curt.p2
	lw t1, 8(s7)
	# t2 = is_visi[curt.p2]
	slli t2, t1, 3
	add t2, t2, s4
	lw t3, 0(t2)
	bne t3, zero, mst_while
	# portal.push()
	addi t4, zero, 3
	mul t4, t4, s2
	slli t4, t4, 3
	add t4, t4, s1
	lw t3, 0(s7)
	sw t3, 0(t4)
	lw t3, 8(s7)
	sw t3, 8(t4)
	lw t3, 16(s7)
	sw t3, 16(t4)
	addi s2, s2, 1
	addi t3, zero, 1
	sw t3, 0(t2)
	# t2 = i
	add t2, zero, zero
mst_loop:
	bge t2, a2, mst_loop_exit
	# t3 = map[curt,p1][i]
	lw t3, 0(s7)
	mul t3, t3, a2
	add t3, t3, t2
	slli t3, t3, 3
	add t3, t3, a6
	lw t3, 0(t3)
	beq t3, zero, mst_if_exit
	# t3 = is_visi[i]
	slli t3, t2, 3
	add t3, t3, s4
	lw t3, 0(t3)
	bne t3, zero, mst_if_exit
	# min_heap.push()
	sw t1, 0(s6)
	sw t2, 8(s6)
	# t3 = map[curt.p2][i]
	mul t3, t1, a2
	add t3, t3, t2
	slli t3, t3, 3
	add t3, t3, a6
	lw t3, 0(t3)
	sw t3, 16(s6)
	addi s6, s6, 24
mst_if_exit:
	addi t2, t2, 1
	beq zero, zero, mst_loop
mst_loop_exit:
	beq zero, zero, mst_while
mst_while_exit:
	# delete curt
	add s7, zero, zero
	# delete[]min_heap
	add s5, zero, zero
	add s6, zero, zero
	# delete[]is_visi
	add s4, zero, zero
	jalr zero, ra, 0
# minimun cost
min_cst:
	# s8 = min
	lui s8, 99999
	add s3, zero, zero
	# t1 = i
	addi t1, zero, 1
min_cst_for_1st:
	blt a4, t1, min_cst_for_1st_ext
	# t2 = total
	add t2, zero, zero
	# t3 = j
	add t3, zero, zero
min_cst_for_2nd:
	bge t3, s2, min_cst_for_2nd_ext
	addi t4, zero, 3
	mul t4, t4, t3
	slli t4, t4, 3
	add t4, t4, s1
	lw t4, 16(t4)
	div t4, t4, t1
	add t2, t2, t4
	addi t3, t3, 1
	beq zero, zero, min_cst_for_2nd
min_cst_for_2nd_ext:
	mul t4, a5, t1
	add t2, t2, t4
	bge t2, s8, min_cst_if_ext
	add s8, t2, zero
	add s3, t1, zero
min_cst_if_ext:
	addi t1, t1, 1
	beq zero, zero, min_cst_for_1st
min_cst_for_1st_ext:
	jalr zero, ra, 0
