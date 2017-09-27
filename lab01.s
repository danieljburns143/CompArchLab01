@Group Memebers: Ryan Green, Connor Green, Dan Burns


@##########################################
@ Lab 01 skeleton
@##########################################
.equ        SWI_PrInt, 0x6b         @ write an integer
.equ        SWI_Exit, 0x11          @ exit code
.equ        Stdout, 1               @ Set output mode to output view


@##########################################
@ Initialization code
@##########################################
main:		ldr 	r3, =my_array	@ Load the starting address of the first
                                    	@ of element of the array of numbers into r3
            mov   r4, #20		@ Total number of elements to be added to list
                                    	@ (ok to "hard code" this)

					                   @ Would keep count of number of items currently added to list

            add 	r5, r3, #400	@ location of first element of linked list
                                    	@ (note that I assume it is at a "random" location
                                    	@  beyond the end of the array.)

					                    @ Would use a register for tail of linked list
                                    	@ (set to 0 for empty list/NULL pointer)

		    mov 	r6, r5		           @ Assume r5 holds the address of next list item;
					                    @ at the start, we want to populate the first item,
                                    	@ of the linked list so we simply copy the address in
                                    	@ r5 into r6.

@###########################################
@# Loop code to building the linked list
@###########################################

mov r9, #0 @make a i to count iterations of loop
mov r7, #4 @set r7 to 4
mov r2, #-1
@Make -1 Node to Start at
str r2, [r5]        @set prev pointer to to -1
str r2, [r5, #8]   @set value of start node to -1
mov r1, r5
add r5, r5, #32
str r5, [r1, #4]  @  set  next pointer of first node to first data node

loadLoop:				@ You should create a loop that cycles through all
            cmp r9, r4
            beq exitLoad                        	@ of the array elements to create a doubly-linked list
            add r6, r5, #32
            mul    r8, r9, r7       @multiply i by 4
            ldr    r2, [r3, r8]     @pull values from array
            mov r14, r15
            b insert

            mov r1, r5
            add r5, r5, #32
            add r9, r9, #1  @iterate i


            b loadLoop
                                    	@ End the loadLoop - Suggestion -- after building the list, add a sentinel
                                			@to the head of the list; you may use the value -1 as we will not test your code with any negative numbers

exitLoad:
	mov r1, #-1
    add r5, r3, #400  @set r5 to the address of the start of the linked list
    str r1, [r6, #4]     @set next pointer on n = 20 to -1

@##########
@#Print Initial Linked List using travers
@##########
@## available registers: r6, r7, r8, r9
mov r14, r15
b print
@##########
@#Sort The List
@##########
add r5, r3, #400
mov r4, #20
mov r1, #1
sort:
  cmp r1,r4
  bge exitSort  @should be sorted if we make it to 20
  mov r2,r1     @i = j
  whiLoop:
    cmp r2,#0
    ble postWhi

  @if j > 0, then we have to find the J element in the list
  mov r7, #0
  add r5, r3, #400
  ldr r5, [r5, #4]  @skip past start node
  findj:
    cmp r2,r7
    beq compj
    add r7, r7, #1
    ldr r5, [r5, #4]
    ldr r6, [r5, #8]
    b findj

  compj:
    @find values of j and j-1
    ldr r7, [r5, #8]  @value of j
    ldr r8, [r5] @r8 is previous location
    ldr r9, [r8, #8]
    @ j is now r7 and j - 1 is now r9
    cmp r7, r9
    bge postWhi  @go to next loop if as j and j-1 are in order
    sub r13, r13, #4	@ make space for r2 to be saved in the stack
    str r2, [r13]
    mov r14,r15
    b swap
    ldr r2, [r13] @pull r2 from the stack
    sub r2, r2, #1		@ j-1 as we move closer to zero
		b	whiLoop			@ go back to start of while loop


  postWhi:
    @commented out code used for testing below
    @sub r13, r13, #4	@ make space for r1 to be saved in the stack
    @str r1, [r13]
    @mov r14, r15
    @b print
    @ldr r1, [r13] @pull r2 from the stack
    add r1,r1,#1
    b sort

exitSort:
@##########
@#Print Sorted List
@##########
mov r14, r15
b print
@##########
@#Delete Duplicates
@##########
@## available registers:
mov r4, #20
add r5, r3, #400
ldr r5, [r5, #4]  @r5 is now the first value node
mov r9, #1  @Initializate counter to 1

deleteloop:
    cmp r9, r4
    bgt doneprune
        ldr r7, [r5]   @location of n -1
        ldr r10, [r5, #8]  @grab value of n
        ldr r11, [r7, #8]  @grab value of n - 1
    cmp r10, r11     @compare n and n - 1
        mov r14, r15
    beq delete       @if they are equal go to delete function to get rid of n
    add r9, r9, #1  @iterate counter
    ldr r5, [r5, #4]  @move to n + 1, after we got rid of n
    b deleteloop


doneprune:

@##########
@#Print Final List
@##########
@## available registers:
mov r14, r15
b print

swi SWI_Exit

@###########################################
@# INSERT FUNCTION -- you must write
@###########################################
insert:
            str r1, [r5]                          @store previous start
            str r6, [r5, #4]                        @store next
            str r2, [r5, #8]                        @store value location
            mov r15, r14

@###########################################
@# SWAP FUNCTION -- you must write
@###########################################
@registers available: r10, 11, 12, 6
swap:
        @ write a function to swap n and n-1
        @ r5 is the address of n
        @ r8 is the address of n-1

        ldr r6, [r5, #4]  @ load next pointer of N
		ldr r10, [r8] @ load previous of N - 1 aka addr of n-2
		str r6, [r8, #4]  @ store next of N as next of N -1
		str r10, [r5] @ store previous of N - 1 as previous of N
		str r5, [r8]@ store N as previous of N - 1
		str r8, [r5, #4]  @ store N - 1 as next of N
		str r8, [r6]  @ store N - 1 as previous of N + 1
		str r5, [r10, #4]  @ store N as next of N - 2

        mov r15,r14

@###########################################
@# DELETE FUNCTION -- you must write
@###########################################
delete:
            @ r5 is the location of n
            @ r7 is the location of n - 1
            @We want to delte n - 1

            ldr r8, [r7]  @ save the addr of n - 2
            str r8, [r5]  @ set prev of n to point to n - 2
            str r5, [r8, #4]  @ set next value of n -2 to point to n          
            mov r15, r14

@###########################################
@# Print Function -- for functionality
@###########################################
print:
  add r5, r3, #400
  printloop:
          ldr r5, [r5, #4]
          mov r0, #Stdout
          ldr r1, [r5,#8]          @load value from memory
          cmp r1, #-1 @check to see if next pointer = -1
          ble printexit   @if r5 is greater than -1, go to the next print
          swi SWI_PrInt      @print current value
          mov r0, #32   @space ASCII
          swi 0x00
          b printloop
    printexit:
        mov r0, #10   @/n ASCII
        swi 0x00
	    mov r15, r14  @return to main
@###########################################
@# ARRAY
@###########################################
.data
          my_array:
                  .word 0x00000002
                  .word 0x00000001
                  .word 0x00000010
                  .word 0x0000000F
                  .word 0x00000004
                  .word 0x00000003
                  .word 0x00000006
                  .word 0x00000005
                  .word 0x0000000A
                  .word 0x00000009
                  .word 0x00000014
                  .word 0x00000013
                  .word 0x0000000C
                  .word 0x0000000B
                  .word 0x00000014
                  .word 0x00000003
                  .word 0x00000012
                  .word 0x00000011
                  .word 0x00000008
                  .word 0x00000007
          .end
