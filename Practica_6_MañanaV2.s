#Practica_6_Mañana del dia 19-05-2020
#Contiene las funciones:
#       -Suma: 
#           ·Recibe como argumentos dos números en punto flotante
#           ·Devuelve la suma de los dos números.
#       -Solicita:
#           ·Pide dos numeros flotantes por consola
#           ·Llama la funcion suma
#           ·Devuelve 1 si la suma es mayor que cualquiera de los
#           sumandos y 0 en caso contrario
#
#El main debe llamar a "solicita" hasta que devuelva 0   
    .data
titulo: 	   .asciiz "~Practica 6 de Principio de Computadores~\n"
flotantes:     .asciiz "Introduzca dos numero flotantes: \n"
float1:        .asciiz "Flotante 1: "
float2:        .asciiz "Flotante 2: "
resultadosuma: .asciiz "El resultado de la suma es: "
endl:          .asciiz "\n"
cero:          .asciiz "Devuelvo 0 por pantalla, empieza de nuevo el programa"
uno:           .asciiz "Devuelve 1 por pantalla, sale del programa"
	.text
 
suma:
	#Almaceno en la pila la dir a la que volver
	sw $ra,4($sp)

    add.s $f22,$f20,$f21 #en $f22 queda el resultado de la suma

    li $v0,4
    la $a0,resultadosuma
    syscall

#Saca por pantalla el resultado de la suma
    li $v0,2
    mov.s $f12,$f22
    syscall

#Salto a la continuacion de "Solicita"
	lw $ra,4($sp)
	jr $ra #return

solicita:
#Almaceno en la pila la dir a la que volver
	sw $ra,0($sp)

#std::cout << "Introduzca dos numero flotantes: ";
    li $v0,4
    la $a0,flotantes
    syscall
   
#std::cout << "Flotante 1: ";
    li $v0,4
    la $a0,float1
    syscall
#std::cin >> numero flotante 1;
    li $v0,6
	syscall
    mov.s $f20,$f0 #$f20 contiene el 1º num flotante introducido

#std::cout << "Flotante 2: ";
    li $v0,4
    la $a0,float2
    syscall
#std::cin >> numero flotante 2;
    li $v0,6
	syscall
    mov.s $f21,$f0 #$f21 contiene el 2º num flotante introducido

#Salto a la funcion "suma"
	jal suma

#Regresa AQUI de la funcion "suma"

#Salto a la continuacion de "main"
	lw $ra,0($sp)
	jr $ra #return main

main:
#std::cout << "Practica 6 de principio de Computadores" << std::endl;
    li $v0,4
    la $a0,titulo
    syscall

programa:
#Push, reservo espacio para un marco de pila.
	addi $sp,-20
	jal solicita

#Regresa AQUI de la funcion "solicita"
	
    bne $f22,$f20,cero
    bne $f22,$f21,uno       #sale del programa

cero:
    li $v0,4
    la $a0,cero
    syscall

    j programa

uno:
    li $v0,4
    la $a0,uno
    syscall

    j exit

exit:
#fin del programa
	li $v0,10
	syscall
 