# TDDing Brainfuck

Look through commit history for steps it took to develop the interpreter using TDD.

Brainfuck is the ungodly creation of Urban Müller, whose goal was apparently to create a Turing-complete language for which he could write the smallest compiler ever, for the Amiga OS 2.0. His compiler was 240 bytes in size.

### The Language

A Brainfuck program has an implicit byte pointer, called "the pointer", which is free to move around within an array of 30000 bytes, initially all set to zero. The pointer itself is initialized to point to the beginning of this array.

The Brainfuck programming language consists of eight commands, each of which is represented as a single character.

| Command       | Action                                                                  | C equivalent    |
| ------------- | ----------------------------------------------------------------------- | --------------- |
| >             | Increment the pointer                                                   | ++p             |
| <             | Decrement the pointer                                                   | --p             |
| +             | Increment the byte at the pointer                                       | ++*p            |
| -             | Decrement the byte at the pointer                                       | --*p            |
| .             | Output the byte at the pointer                                          | putchar(*p)     |
| ,             | Input a byte and store it in the byte at the pointer                    | *p = getchar()  |
| [             | Jump forward past the matching ] if the byte at the pointer is zero     | while (*p) {    |
| ]             | Jump backward to the matching [ unless the byte at the pointer is zero  | }               |

### The Implementation

* The only instructions used are `< > - + , . [ ]`, anything else is a comment and not considered a part of the program (including newlines)
* No special terminating character is used
* Cells can contain values from 0 to 255
* Incrementing 255 or decrementing 0 results in a fatal error
* Memory size is 30 000 cells
* Attempting to go to the left of the starting cell is a fatal error
* `,` returns 0 on EOF
* Unbalanced brackets are a fatal error
* After EOF is reached (`,` returns 0), further atempt to use `,` will result in a fatal error
* If the problem specifies that input is not used, `,` cannot be used at all. Trying to use it will result in, you guessed it, a fatal error
* Programs are limited to 64K
