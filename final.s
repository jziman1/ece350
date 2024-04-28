nop
nop
nop
nop
nop

top:
addi $r11, $r0, 1 // Initialize numbers
addi $r12, $r0, 2
addi $r13, $r0, 3
addi $r14, $r0, 4
addi $r15, $r0, 5
addi $r16, $r0, 6
addi $r17, $r0, 7
addi $r18, $r0, 8
addi $r19, $r0, 9
addi $r20, $r0, 10

addi $r1, $r0, 0 // Initialize variables
addi $r2, $r0, 0
addi $r3, $r0, 0
addi $r21, $r0, 0
addi $r22, $r0, 0
addi $r23, $r0, 0

read:
lw $r1, 5($r0) // $r1 = keypad entry
bne $r1, $r0, next // If keypad entry != 0, go to next
j read
next:
bne $r1, $r20, standard // If keypad entry != 10, go to standard mode

nop
sw $r0, 7($r0) // If enter 0, turn remainder light off
nop

nop
sw $r11, 11($r0) // Turn on mode LED
nop

sw $r11, 6($r0) // For debugging

sll $r25, $r11, 21
delay_one:
addi $r23, $r23, 1
bne $r23, $r25, delay_one

input_players:
lw $r21, 5($r0) // $r21 = keypad entry
bne $r21, $r0, first_continue // If keypad entry != 0, go to first_continue
j input_players
first_continue:

sw $r21, 6($r0) // For debugging

addi $r23, $r0, 0 // Reset counter
sll $r25, $r11, 21
delay_two:
addi $r23, $r23, 1
bne $r23, $r25, delay_two

bne $r21, $r20, cont_one // go back to read if enter zero again
nop
sw $r0, 11($r0) // Turn off LED
nop
j top
cont_one:

input_cards:
lw $r22, 5($r0) // $r22 = number of cards
bne $r22, $r0, second_continue
j input_cards
second_continue:

sw r$22, 6($r0) // For debugging

addi $r23, $r0, 0 // Reset counter
sll $r25, $r11, 21
delay_three:
addi $r23, $r23, 1
bne $r23, $r25, delay_three

bne $r22, $r20, cont_two // go back to read if enter zero again
nop
sw $r0, 11($r0) // Turn off LED
nop
j top
cont_two:

nop
sw $r0, 11($r0) // Turn off LED

addi $r1, $r21, 0 // $r1 = number of players
mul $r2, $r1, $r22 // $r2 = number of cards to be distributed (players*cards)

nop
nop
sw $r2, 6($r0)

j loop

standard:
nop
sw $r0, 11($r0)
addi $r2 $r0 10 // Distribute 10 cards. Change to 52 for a full deck
nop

bne $r1, $r12, remainder_one // If key != 2, go to next
sw $r0, 7($r0)
j remainder_three
remainder_one:

bne $r1, $r14, remainder_two // If key != 4, go to next
sw $r0, 7($r0)
j remainder_three
remainder_two:

nop
sw $r11, 7($r0) // Turn on LED

remainder_three:

loop:

nop
nop
bne $r1, $r12, not_two // if(keypad != 2) then skip next instructions
nop // 11111000000000000000000001111110
nop

not_two:
bne $r1, $r13, not_three // if(keypad != 3) then skip next instructions
nop // 11111000000000000000000001010100
nop

not_three:
bne $r1, $r14, not_four // if(keypad != 4) then skip next instructions
nop // 11111000000000000000000000111111
nop

not_four:
bne $r1, $r15, not_five // if(keypad != 5) then skip next instructions
nop // 11111000000000000000000000110010
nop

not_five:
bne $r1, $r16, not_six // if(keypad != 6) then skip next instructions
nop // 11111000000000000000000000101010
nop

not_six:
bne $r1, $r17, not_seven // if(keypad != 7) then skip next instructions
nop // 11111000000000000000000000100100
nop

not_seven:
bne $r1, $r18, not_eight // if(keypad != 8) then skip next instructions
nop // 11111000000000000000000000100000
nop

not_eight:
bne $r1, $r19, not_nine // if(keypad != 9) then skip next instructions
nop // 11111000000000000000000000011100
nop

not_nine:
addi $r3, $r3, 1 // Add to counter
bne $r2, $r3, loop // if(counter != limit) then go to loop
j top
