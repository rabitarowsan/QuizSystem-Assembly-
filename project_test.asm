.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB '                .....WELCOME TO YOUR FIRST QUIZ.....$'
    userNamePrompt DB 'Please enter your name: $'
    welcomeMessage DB 'Welcome, $' ; Placeholder for user name insertion   
    
    rulesMessage1       DB 'Quiz Rules:$'
    rulesMessage2       DB '1. For every correct answer, you get +1 point.$'
    rulesMessage3       DB '2. For every wrong answer, you lose 1 point$'
    rulesMessage4       DB '3. To skip a question, press "s". No points will be added or deducted.$'
    rulesMessage5       DB 'Press any key to start the quiz...$' 
    rulesArray DW OFFSET rulesMessage1
               DW OFFSET rulesMessage2
               DW OFFSET rulesMessage3
               DW OFFSET rulesMessage4
               DW OFFSET rulesMessage5
                               
                    
    subjectMenu1    DB 'Choose a subject:$'
    subjectOption1  DB '1. Microprocessors Introduction$'
    subjectOption2  DB '2. Basic I/O and Arithmetic Operations$'
    subjectOption3  DB '3. Control Flow and Branching$'
    subjectOption4  DB '4. Looping Structures$'
    subjectOption5  DB '5. Arrays$'
    subjectOption6  DB '6. STACK$'
    subjectPrompt   DB 'Enter choice (1-6): $'
    subjectOptionsArray DW OFFSET subjectOption1
                        DW OFFSET subjectOption2
                        DW OFFSET subjectOption3
                        DW OFFSET subjectOption4
                        DW OFFSET subjectOption5
                        DW OFFSET subjectOption6
    subjectChoice   DB ?  ; Buffer for storing user choice
    
    retakeMenu DB 'Press 1 to retake the quiz, 2 to see correct answers, or 0 to exit.$'
    correctAnswerMessage DB 'Correct answer!$'
    wrongAnswerMessage DB 'Wrong answer..!$'
    skipMessage DB 'Question skipped.$'
    finalScoreMessage DB 'Your total score is: ', 0  ; Placeholder for score insertion
    viewAnswersMessage DB 'Correct Answers: ', 0DH, 0AH  ; Placeholder for correct answers
    
    ; Subject-1: Microprocessors Introduction
    
    sub1_q1 DB '1. What does a microprocessor primarily manage?$'
    sub1_q2 DB '2. Who is known as the father of the microprocessor?$'
    sub1_q3 DB '3. The Intel 4004 is known as?$'
    sub1_q4 DB '4. What is the function of the ALU?$'
    sub1_q5 DB '5. Which of the following is a function of the control unit?$'
    sub1_q6 DB '6. The term "clock speed" of a microprocessor refers to?$'
    sub1_q7 DB '7. In what year was the first microprocessor developed?$'
    sub1_q8 DB '8. RISC stands for?$'
    sub1_q9 DB '9. What is pipelining in a microprocessor?$'
    sub1_q10 DB '10. Which of the following is not a part of a microprocessor?$'
    sub1_questionsArray DW OFFSET sub1_q1
                   DW OFFSET sub1_q2 
                   DW OFFSET sub1_q3 
                   DW OFFSET sub1_q4 
                   DW OFFSET sub1_q5 
                   DW OFFSET sub1_q6 
                   DW OFFSET sub1_q7 
                   DW OFFSET sub1_q8 
                   DW OFFSET sub1_q9 
                   DW OFFSET sub1_q10

    ; Options for Subject 1
    sub1_opts1 DB 'A) Arithmetic operations B) Control operations C) Data management D) External communication$'
    sub1_opts2 DB 'A) Charles Babbage B) Marcian Hoff C) Bill Gates D) Steve Jobs$'
    sub1_opts3 DB 'A) The first microcontroller B) The first microprocessor C) The first computer D) The first calculator$'
    sub1_opts4 DB 'A) Data storage B) Data processing C) Peripheral management D) Power management$'
    sub1_opts5 DB 'A) Arithmetic operations B) Flow control C) Data transfer D) Logic operations$'
    sub1_opts6 DB 'A) The physical size B) The number of instructions per second C) The power consumption D) The memory size$'
    sub1_opts7 DB 'A) 1971 B) 1981 C) 1961 D) 1991$'
    sub1_opts8 DB 'A) Reduced Instruction Set Computer B) Real Instruction Set Computer C) Random Instruction Set Computer D) None of the above$'
    sub1_opts9 DB 'A) A method to increase power consumption B) A technique to reduce processing time C) A memory management technique D) None of the above$'
    sub1_opts10 DB 'A) ALU B) Control Unit C) Cache Memory D) External Hard Drive$'
    sub1_optionsArray DW OFFSET sub1_opts1
                 DW OFFSET sub1_opts2
                 DW OFFSET sub1_opts3
                 DW OFFSET sub1_opts4
                 DW OFFSET sub1_opts5
                 DW OFFSET sub1_opts6 
                 DW OFFSET sub1_opts7 
                 DW OFFSET sub1_opts8 
                 DW OFFSET sub1_opts9 
                 DW OFFSET sub1_opts10

    ; Correct Answers for Subject 1
    sub1_answersArray DB 'B', 'B', 'B', 'B', 'B', 'B', 'A', 'A', 'B', 'D'
    
    questionPrompt DB 'Enter your answer (A, B, C, or D): $'

    
    
    
    ; User Input Buffers
    userNameInput DB 20 DUP('$')  ; Buffer to store user name
    userChoice DB 1 DUP('$')

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display welcome message
    MOV DX, OFFSET MSG1
    MOV AH, 09H
    INT 21H

    ; Prompt for user name
    MOV DX, OFFSET userNamePrompt
    MOV AH, 09H
    INT 21H
    LEA DX, userNameInput
    MOV AH, 0AH
    INT 21H

    ; Display personalized welcome message
    LEA DX, [userNameInput + 2]
    MOV AH, 09H
    INT 21H
    MOV DX, OFFSET welcomeMessage
    INT 21H

    ; Display rules
    MOV CX, 5
    MOV SI, OFFSET rulesArray
    PRINT_RULES:
        MOV DX, [SI]
        MOV AH, 09H
        INT 21H
        ADD SI, 2
        LOOP PRINT_RULES

    ; Wait for any key press
    MOV AH, 07H
    INT 21H

    ; Display subject menu
    MOV DX, OFFSET subjectMenu1
    MOV AH, 09H
    INT 21H
    MOV CX, 6
    MOV SI, OFFSET subjectOptionsArray
    PRINT_SUBJECTS:
        MOV DX, [SI]
        MOV AH, 09H
        INT 21H
        ADD SI, 2
        LOOP PRINT_SUBJECTS

    ; Get user's subject choice
    MOV DX, OFFSET subjectPrompt
    MOV AH, 09H
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, '1'
    MOV subjectChoice, AL

    ; Check subject choice and display questions
    MOV AL, subjectChoice
    CMP AL, 0  ; Subject 1
    JNE END_PROGRAM  ; For simplicity, assuming only subject 1 is implemented
    
    MOV CX, 10
    MOV SI, OFFSET sub1_questionsArray
    MOV DI, OFFSET sub1_optionsArray
    
    MOV BX, 0 
    MOV CX, 10
    
    DISPLAY_QUESTIONS:
    ; Display question
    MOV DX, [SI + BX * 2]
    MOV AH, 09H
    INT 21H ;display questions      
    
    MOV DX, [DI + BX * 2]
    INT 21H ;display options    
    
    ;prompt for user's answer
    MOV DX, OFFSET questionPrompt
    INT 21H
    MOV AH, 01H
    INT 21H
    MOV userChoice, AL

    ; Skip handling
    CMP AL, 's'
    JE SKIP_QUESTION
    CMP AL, 'S'
    JE SKIP_QUESTION

    ; Convert user's answer to uppercase if it's a lowercase letter
    CMP AL, 'a'
    JB NO_CONVERSION
    CMP AL, 'z'
    JA NO_CONVERSION
    SUB AL, 'a' - 'A'  ; Convert to uppercase

NO_CONVERSION:

    ; Check if the user's answer is correct
    MOV AH, [sub1_answersArray + BX]  ; Get the correct answer
    CMP AH, AL  ; Compare user's choice with the correct answer
    JNE INCORRECT_ANSWER

CORRECT_ANSWER:
    ; Correct answer handling
    MOV DX, OFFSET correctAnswerMessage
    JMP FEEDBACK

INCORRECT_ANSWER:
    ; Incorrect answer handling
    MOV DX, OFFSET wrongAnswerMessage
    JMP FEEDBACK

SKIP_QUESTION:
    ; Skip question handling
    MOV DX, OFFSET skipMessage

FEEDBACK:
    ; Display feedback message
    MOV AH, 09H
    INT 21H

    ; Prepare for the next question
    INC BX  ; Increment question index

    ; Directly decrement CX and use JNZ to continue loop if CX is not zero
    DEC CX
    JNZ DISPLAY_QUESTIONS

    ; End of the quiz
    JMP END_PROGRAM


    END_PROGRAM:
    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN
