; ----------------------------------------------------------------
; Create a procedure named CalcGrade that receives an integer value between 0
; and 100, and returns a single capital letter in the AL register.Preserve all other
; register values between calls to the procedure.
; 
; Write a test program that generates 10 random integers between 50 and 100, inclusive.
; Each time an integer is generated, pass it to the CalcGrade procedure.You can test
; your program using a debugger, or if you prefer to use the book's library, you can
; display each integer and its corresponding letter grade.
; ----------------------------------------------------------------

INCLUDE Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode: dword

.data
    prompt1 BYTE "With a score of ", 0
    prompt2 BYTE " your grade is ", 0

.code
main PROC
    call	Randomize       ; init random generator
    call	Randy
EndProgram:
    invoke ExitProcess, 0

main ENDP

; ------------------------------------------------
Randy PROC
; Generate ten random integers between 50 and 100
; Call CalcGrade to calculate the letter grade based
; on the generate number
; ------------------------------------------------
    mov ecx, 10                 ; loop 10 times

L1 :
    mov eax, 51                 ; values 0 - 50
    call RandomRange            ; generate random int
    add eax, 50                 ; add 50 to EAX to be in range 50 - 100
    mov edx, OFFSET prompt1
    call WriteString            ; Print prompt1
    call WriteInt               ; Print the integer value generated
    mov edx, OFFSET prompt2
    call WriteString            ; Print prompt2
    call CalcGrade
    call Crlf
    loop L1
    ret
Randy ENDP

; ------------------------------------------------
CalcGrade PROC
; Receive the grade number and convert it into
; a letter grade to A, B, C, D or F according to
; the generate number grade.
; Print to the console the Letter Grade
; ------------------------------------------------
    push    eax          ; Preserve Registers
    push    ecx
    push    edx

    cmp eax, 90
    jge GradeA
    cmp eax, 80
    jge GradeB
    cmp eax, 70
    jge GradeC
    cmp eax, 60
    jge GradeD
    jmp GradeF

GradeA :
    mov al, 'A'
    jmp Done

GradeB :
    mov al, 'B'
    jmp Done

GradeC :
    mov al, 'C'
    jmp Done

GradeD :
    mov al, 'D'
    jmp Done

GradeF :
    mov al, 'F'

Done :
    call WriteChar      ; Print the character value of the grade
    pop    edx          ; Restore Registers
    pop    ecx
    pop    eax
    ret

CalcGrade ENDP
END main
