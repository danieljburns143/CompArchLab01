@##########################################
@ Lab 01 skeleton
@##########################################
.equ         SWI_PrInt, 0x6b         @ write an integer
.equ        SWI_Exit, 0x11          @ exit code
.equ        Stdout, 1         @ Set output mode to output view


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

mov r9, #0 @make a i to count itterations of loop
add r7, r7, #4
mov r1, #-1

loadLoop:				@ You should create a loop that cycles through all
                                    	@ of the array elements to create a doubly-linked list

            mul    r8, r9, r7      @multiply i by 4
      		add	   r5, r5, #32	@ When you insert a new item into a linked list, you
                                    @ might use a malloc command to allocate memory for the
                                    @ next struct; to mimic this, I simply add a random number
                                    @ (32 for non contiguous allocation) to the first element
                                    @ of the linked list
            ldr    r2, [r3, r8]     @pull values from array
            mov r14, r15
            b insert


                                    	@ Call a function to add item to list
            add r9, r9, #1
						cmp r9, r4								@ check to see if r4 is greater than or equal to 20
						bge exitLoad							@if it is exit, if not move to next node
            add r6, r6, #4              @ r6 is now the address of data point in previous node
            mov r1, r6                  @ r1 is r6
            mov r6, r5                  @ r6 is the new start of the next node
            b loadLoop
                                    	@ End the loadLoop - Suggestion -- after building the list, add a sentinel
                                			@to the head of the list; you may use the value -1 as we will not test your code with any negative numbers
@##########
@#Array Loaded
@##########
exitLoad:
	mov r1, #-1
	str r1, [r6, #8]     @set tail pointer to -1
	ldr r5, [r3, #400]   @set r5 to the address of the start of the linked list
@##########
@#Print Initial Linked List using traversion
@##########
mov r14, r15
b print
@##########
@#Sort The List
@##########
@##########
@#Print Sorted List
@##########
@##########
@#Delete Duplicates
@##########
@##########
@#Print Final List
@##########


@###########################################
@# INSERT FUNCTION -- you must write
@###########################################
insert:
            str r1, [r6]                          @store previous location
            str r2, [r6, #4]                        @store value
            str r5, [r6, #8]                        @store Next Location
            mov r15, r14

@###########################################
@# SWAP FUNCTION -- you must write
@###########################################
swap:
@###########################################
@# DELETE FUNCTION -- you must write
@###########################################
delete:
					@save next value of node being deleted
					@go back to previous node and update next value to register just used
					@save location of current register
					@go to next new next node
					@update previous value of current register, to the node we just left



@###########################################
@# Print Function -- for functionality
@###########################################
print:
	@load value from memory
	@print current value
	@load next address from memory
	@check to see if next pointer == -1
	@if not, go to next node
	@loop back up


	@exit the printing loop
	mov r15, r14  @return to main
@###########################################
@# ARRAY
@###########################################
.data
            my_array:
                  .word 0x00000000
                  .word 0x00000001
                  .word 0x00000002
                  .word 0x00000003
                  .word 0x00000004
                  .word 0x00000005
                  .word 0x00000006
                  .word 0x00000007
                  .word 0x00000008
                  .word 0x00000009
                  .word 0x0000000A
                  .word 0x0000000B
                  .word 0x0000000C
                  .word 0x0000000D
                  .word 0x0000000E
                  .word 0x0000000F
            .end
