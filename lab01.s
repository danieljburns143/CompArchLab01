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

loadLoop:				@ You should create a loop that cycles through all
                                    	@ of the array elements to create a doubly-linked list

            add    r1, r1, #4       @fuck ARMSim
            mul    r8, r9, r1      @multiply i by 4
		add	 r6, r6, #32	@ When you insert a new item into a linked list, you
            ldr    r0, [r3, r8]     @pull values from array
            b print
            
                                    	@ might use a malloc command to allocate memory for the
                                    	@ next struct; to mimic this, I simply add a random number
					@ (32 for non contiguous allocation) to the first element
                                    	@ of the linked list


                                    	@ Call a function to add item to list
            add r9, r9, #1
            cmp r9, r4
            blt loadLoop
                                    	@ End the loadLoop

                                    	@ Suggestion -- after building the list, add a sentinel
                                    	@ to the head of the list; you may use the value -1 as 
                                    	@ we will not test your code with any negative numbers

print:      
            mov   r0, #Stdout @ mode is output view
            mov   r1, r2            @ integer to print (value in r2); value to 
                              @ print must be in r1

            swi     SWI_PrInt   @ print integer
            swi     SWI_Exit. @exit function
                                    	
@###########################################
@# INSERT FUNCTION -- you must write
@###########################################


@###########################################
@# SWAP FUNCTION -- you must write
@###########################################


@###########################################
@# DELETE FUNCTION -- you must write
@###########################################



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
