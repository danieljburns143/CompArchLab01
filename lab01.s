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

		mov 	r6, r5		@ Assume r5 holds the address of next list item;
					@ at the start, we want to populate the first item,
                                    	@ of the linked list so we simply copy the address in
                                    	@ r5 into r6.

@###########################################
@# Loop code to building the linked list
@###########################################

mov r9, #0 @make a i to count iterations of loop
add r7, r7, #4
mov r2, #-1
@Make -1 Node at start, and iterate r5 to r5 + 32 (start of list)
str r5, [r5]        @set prev pointer to its location
str r2, [r5, #8]   @set value of start node to -1
mov r1, r5         @save value of start
add r5, r5, #32   @iterate to the true node 1
str r5, [r1, #4]  @place location of node 1 in the next pointer of the start node

loadLoop:				@ You should create a loop that cycles through all
                                    	@ of the array elements to create a doubly-linked list

            mul    r8, r9, r7   @multiply i by 4
            ldr    r2, [r3, r8]     @pull values from array
            mov r14, r15
            b insert


                                    	@ Call a function to add item to list
            add r9, r9, #1
						cmp r9, r4								@ check to see if r4 is greater than or equal to 20
						bge exitLoad							@if it is exit, if not move to next node

            mov r1, r6
            mov r6, r5
            add r5, r5, #32


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
  findj:
    cmp r2,r7
    beq compj
    ldr r5, [r5, #4]
    add r7, r7, #1
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
    add r1,r1,#1
    b sort

exitSort:

@##########
@#Print Sorted List
@##########
@## available registers:
add r5, r3, #400
mov r14, r15
b print

swi SWI_Exit
@##########
@#Delete Duplicates
@##########
@## available registers:




@##########
@#Print Final List
@##########
@## available registers:
@@@@@add r5, r3, #400
@@@@@mov r14, r15
@@@@@b print


@###########################################
@# INSERT FUNCTION -- you must write
@###########################################
insert:
            str r1, [r6]                          @store previous start
            str r5, [r6, #4]                        @store next
            str r2, [r6, #8]                        @store value location
            mov r15, r14

@###########################################
@# SWAP FUNCTION -- you must write
@###########################################
@registers available: r2, r1, r6, r7, r8, r9
swap:
        @ write a function to swap n and n-1
        @ assume r5 is the address of n

        ldr r2, [r5]  @load address of n-1
        ldr r6, [r8]  @load address of n - 2
        str r5, [r6, #4]  @send next of n-2 to point to address of n

        ldr r6, [r5, #4] @load address of n+1 (next pointer of n)
        str r2, [r6]  @send the prev pointer in n+1 to point to n-1

        @load the next pointer of n
        @load the next pointer of n - 1
        str r6, [r2, #4] @set the next pointer of n-1 to the next of n
        str r2, [r5, #4] @set the next pointer of n to the the addr of n

        ldr r6, [r2]  @load the prev pointer of n-1
        @load the prev pointer of n (which is addr of n-1)
        str r6, [r5]  @set the prev pointer of n to the prev pointer of n -1, which is the addr of 2
        str r5, [r2]  @set the prev pointer of n-1 to the addr of n


        mov r15,r14

@###########################################
@# DELETE FUNCTION -- you must write
@###########################################
delete:
            @save next value of node being deleted
            @go back to previous node and update next value to register just used
            @save location of current register
            @go to next new next node
            @update previous value of current register, to the node we just left
                      
          ldr r6, [r5]   @r6 is now the start of n-1
          ldr r7, [r5, #4]  @load r7 to be the next pointer of n
          str r7, [r6, #4]  @put the next pointer of n into the next pointer of n-1

          str r6, [r7]  store the address of n-1, in the previous data of n+1


@###########################################
@# Print Function -- for functionality
@###########################################
print:
  mov r0, #Stdout
  mov r8, #-1
	ldr r1, [r5,#8]          @load value from memory
	swi SWI_PrInt      @print current value
  mov r0, #32   @space ASCII
  swi 0x00
	ldr r5, [r5,#4]          @load next address from memory
  cmp r5, r8 @check to see if next pointer = -1
	bgt print   @if r5 is greater than -1, go to the next print
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
                  .word 0x0000000E
                  .word 0x0000000D
                  .word 0x00000012
                  .word 0x00000011
                  .word 0x00000008
                  .word 0x00000007
          .end
