.
.  File; SP-COPY.ASM
.  Date: (A) Creation - 2021/10/16     (B) Modified - 2021/10/19
.  Notes:
.  (1) This program is the same as the program in Figure 2.1 (pp. 45)
.  (2) This file is intended to be an example program for SIC Assembler
.  (3) The fixed format of each line:
.          COL. 1       - . (the entire line is comment)
.          COL. 1 ~ 8   - Label (optional)
.          COL. 9       - Blank
.          COL. 10 ~ 15 - Operation code mnemonic or assembler directive
.          COL. 16 ~ 17 - Blank
.          COL. 18 ~ 35 - Operand(s)
.          COL. 36 ~ 66 - Comment (optional)
.  Usage:
.  (A) Rename this file to SRCFILE
.  (B) Execute SIC assembler
.
.0       1         2         3         4         5         6         7
.23456789012345678901234567890123456789012345678901234567890123456789012
.
COPY     START   1000              Copy file from INPUT to OUTPUT
FIRST    STL     RETADR            Save return address
CLOOP    JSUB    RDREC             Read input record
         LDA     LENGTH            Test for EOF (LENGTH = 0)
         COMP    ZERO
         JEQ     ENDFIL            Exit if EOF found/read
         JSUB    WRREC             Write output record
         J       CLOOP             Loop
ENDFIL   LDA     EOF               Insert End-of-File marker
         STA     BUFFER
         LDA     THREE             Set LENGTH = 3
         STA     LENGTH
         JSUB    WRREC             Write EOF to output file
         LDL     RETADR            Get return address
         RSUB                      Return to caller
EOF      BYTE    C'EOF'
THREE    WORD    3
ZERO     WORD    0
RETADR   RESW    1
LENGTH   RESW    1                 Length of record
BUFFER   RESB    4096              4096-BYTE Buffer area
.
.        SUBROUTINE TO READ RECORD INTO BUFFER
.
RDREC    LDX     ZERO              Clear loop counter
         LDA     ZERO              Clear A register to zero
RLOOP    TD      INPUT             Test input device
         JEQ     RLOOP             Loop until device ready
         RD      INPUT             Read a character into register A
         COMP    ZERO              Test for End-of-Record (X'00')
         JEQ     EXIT              Exit loop if EOR encountered
         STCH    BUFFER,X          Store character in buffer
         TIX     MAXLEN            Loop unless the max length
         JLT     RLOOP               has been reached
EXIT     STX     LENGTH            Save record length
         RSUB                      Return to caller
INPUT    BYTE    X'F1'             Code for the input device
MAXLEN   WORD    4096
.
.        SUBROUTINE TO WRITE RECORD FROM BUFFER
.
WRREC    LDX     ZERO              Clear loop counter
WLOOP    TD      OUTPUT            Test output device
         JEQ     WLOOP             Loop until device ready
         LDCH    BUFFER,X          Get characteer from buffer
         WD      OUTPUT            Write a character
         TIX     LENGTH            Loop until all characters
         JLT     WLOOP               have been written
         RSUB                      Return to caller
OUTPUT   BYTE    X'05'             Code for the output device
         END     FIRST