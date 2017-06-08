# Angel Armando Avila Chavira is697755
# Cristhian Franco Reynoso    is697163

.text
Main:
	addi $s0, $zero, 16		# Numero de discos
	add  $t0, $zero, $s0		# Temporal para llenado
	addi $a1, $zero, 0x10010000	# a1 torre de inicio
	add  $a2, $zero, 0x10010004	# a2 torre auxiliar
	add  $a3, $zero, 0x10010008	# a3 torre destino
	addi $s1, $zero, 1		# Variable para comparar si n = 1
	
# ===================== Llenado de discos =====================
Init:
	sw   $t0, 0($a1)	# Guardamos el disco en la torre de inicio
	addi $t0, $t0, -1	# BP: Restamos uno al numero de discos
	addi $a1, $a1, 32	# Avanzamos 4 en memoria	
	bne  $t0, $zero, Init	# Hasta que sean 0 discos, seguimos metiendolos en la torre de inicio
	jal  Hannoi
	j    Exit
# //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
Hannoi:
	beq  $s0, $s1, Mover	# Si n = 1, movemos discos
	addi $sp, $sp,-8 	# Restamos el sp
	sw   $ra, 4($sp) 	# Guardamos la direccion de retorno
	sw   $s0, 0($sp) 	# Guardamos n
	
	addi $s0, $s0, -1	# Restamos n
	
# ===================== Primeros swaps =====================
	add  $t2, $a2, $zero	# Swap de torre auxiliar con la de destino
	add  $a2, $a3, $zero
	add  $a3, $t2, $zero
	
	jal Hannoi		# Volvemos a llamar Hannoi
	
	add  $t2, $a2, $zero	# Swap de torre auxiliar con la de destino
	add  $a2, $a3, $zero
	add  $a3, $t2, $zero
	
	jal Mover	
# ===================== Segundos swaps =====================
	add $t2, $a2, $zero	# Swap de torre de inicio con la auxiliar
	add $a2, $a1, $zero
	add $a1, $t2, $zero
	
	jal  Hannoi
	
	add $t2, $a2, $zero	# Swap de torre de inicio con la auxiliar
	add $a2, $a1, $zero
	add $a1, $t2, $zero
# ===================== Carga de datos del sp =====================
	lw   $ra, 4($sp)	# Carga el return address anterior
	lw   $s0, 0($sp)	# Carga la cantidad de discos anteriores
	addi $sp, $sp, 8	# Le regresamos lo que habíamos restado al sp
	
	jr $ra
	
# //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Mover:	
	lw   $t5, -32($a1)	# Carga el disco del tope de la torre de origen
	sw   $zero, -32($a1)	# Y lo borramos (pop)
	
	sw   $t5, 0($a3)	# Guardamos el disco en la torre de destino
	
	addi $a3, $a3, 32	# BP: Modificamos los apuntadores de las torres
	addi $a1, $a1, -32
	jr $ra

Exit: