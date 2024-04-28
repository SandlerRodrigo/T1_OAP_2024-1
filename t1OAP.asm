.data
	$Txt0: .asciiz "Programa de Raíz Quadrada - Newton-Raphson\n\nDesenvolvedores: Alex Fraga, Bernardo Fioreze, Rafael Roth, Rodrigo Sandler\n\n----------------------------------------------------------------------------"
	$Txt1: .asciiz "\n\nPara abortar a execução a qualquer momento, insira um numero negativo!!!\n\nPara calcular sqrt(x,i), informe o que pede:\n\nDigite o 'x':\n\n"
	$Txt2: .asciiz "\nDigite o 'i':\n\n"
	$Txt3: .asciiz "\nEncerrando programa...\n"
	$Txt4: .asciiz "\n------------------------------\n| sqrt("
	$Txt5: .asciiz ","
	$Txt6: .asciiz ") = "
	$Txt7: .asciiz "\n------------------------------"
	# sqrt(500,8) = 22
	.align 2

.macro end
	li $v0, 10
	syscall
.end_macro

.macro print_string(%str)
	move $a0, %str
	li $v0, 4
	syscall
.end_macro

.macro print_int(%int)
	move $a0, %int
	li $v0, 1
	syscall
.end_macro

.macro read_int(%int)
	li $v0, 5
	syscall
	move %int, $v0
.end_macro

.macro callSqrt(%answer)
	jal squareRoot
	move %answer, $v0
.end_macro

.text
	.globl main
main:
	#-------------------------------------------------------------#
	la $t0, $Txt0 # carrega apresentação
	print_string($t0) # printa
	j loop
	#-------------------------------------------------------------#
loop:
	addiu $sp, $sp, 12 # aloca 3 espaços na pilha
	sw $ra, 0($sp) # salva retorno da main em (pilha + 0)
	
	la $t0, $Txt1 # carrega instruções e pergunta "x"
	print_string($t0) # printa
	read_int($s0) # recebe "x"
	sw $s0, 4($sp) # salva input "x" em (pilha + 4)
	
	bltz $s0, fim # finaliza com input negativo
	
	la $t0, $Txt2 # pergunta "i"
	print_string($t0) # printa
	read_int($s1) # recebe "i"
	sw $s1, 8($sp) # salva input "i" em (pilha + 8)
	
	bltz $s1, fim # finaliza com input negativo
	
	callSqrt($t1) # chama a função e escreve resposta em $t1
	addiu $sp, $sp, -12 # destroi pilha
	
	#------------Printa Resposta-------------#
	la $t0, $Txt4
	print_string($t0)
	print_int($s0) # 'x' inputado pelo usuário
	la $t0, $Txt5
	print_string($t0)
	print_int($s1) # 'i' inputado pelo usuário
	la $t0, $Txt6
	print_string($t0)
	print_int($t1) # t1, que guarda retorno do metodo sqrt
	la $t0, $Txt7
	print_string($t0)
	#----------------------------------------#
	
	j loop
	
squareRoot:
	lw $a0, 4($sp) # x
	lw $a1, 8($sp) # i
	bne $a1, $zero, recurs # while $a1('i') != 0, retorna recursivo
		li $v0, 1 # se $a1('i') = 0, retorna "1" 
		jr $ra
recurs:
	addiu $a1, $a1, -1 # decresce 'i'
	addiu $sp, $sp, -12 # abre espaço na pilha
	sw $ra, 0($sp) # guarda endereço de retorno na pilha
	sw $a0, 4($sp) # guarda 'x' na pilha
	sw $a1, 8($sp) # guarda 'i' na pilha
	jal squareRoot
	lw $ra, 0($sp) # recupera endereço retorno
	lw $a0, 4($sp) # recupera x
	lw $a1, 8($sp) # recupera i
	addiu $sp, $sp, 12 # destroi a pilha
	#-----Fórmula------#
	div $a0, $v0
	mflo $t0
	addu $v0, $v0, $t0
	srl $v0, $v0, 1
	#------------------#
	jr $ra
fim:
	la $t0, $Txt3
	print_string($t0)	
	end