INCLUDE Irvine32.inc
INCLUDE Macros.inc
Includelib winmm.lib

PlaySound PROTO,
        pszSound:PTR BYTE, 
        hmod:DWORD, 
        fdwSound:DWORD
   
.data

;///////////including music/////////
SND_FILENAME DWORD 00020000h
SND_LOOP DWORD  00000008h
SND_ASYNC DWORD 00000001h
file BYTE "audio.wav" , 0

;///////////ghost///////////
swag6 db ?
swag8 db ?
swag9 db ?
swag7 db ?
swag4 db ?
swag5 db ?
swag2 db ?
swag1 db ?
swag3 db ?
xghost db 10
yghost db 19
xghost1 db 22
yghost1 db 5
xghost2 db 41
yghost2 db 5
xghost3 db 71
yghost3 db 5
xghost4 db 6
yghost4 db 4
xghost5 db 114
yghost5 db 4
xghost6 db 47
yghost6 db 26
xghost7 db 65
yghost7 db 26

xghost8 db 8
yghost8 db 23
xghost9 db 114
yghost9 db 22

;////life////
life dw 3
name db ?
inc1 db ?
var db "$",0
x byte 5000 dup (0) 
y byte 5000 dup (0)
dot byte "$"
extra byte "#",0
xcoins byte 5000 dup(0)
ycoins byte 5000 dup(0)

xextra byte 1000 dup(0)
yextra byte 1000 dup(0)
;/////////////displaying menu/////////////

stringmenu1  db               "|||         |||  ||||||||  |||        ||  ||      ||",0
stringmenu2  db               "|| ||     || ||  ||        || ||      ||  ||      ||",0
stringmenu3  db               "||  ||   ||  ||  ||        ||  ||     ||  ||      ||",0
stringmenu4  db               "||   || ||   ||  ||||||||  ||   ||    ||  ||      ||",0
stringmenu5  db               "||    ||     ||  ||        ||    ||   ||  ||      ||",0
stringmenu6  db               "||           ||  ||        ||     ||  ||  ||      ||",0
stringmenu7  db               "||           ||  ||        ||      || ||  ||      ||",0
stringmenu8  db               "||           ||  ||||||||  ||       ||||  ||||||||||",0
               

userName    BYTE 100 DUP(?)
rollNo      BYTE 10 DUP(?)
menuPrompt1  BYTE           "1. Enter Name : ", 0
menuPrompt2  db "2. Enter Roll No : ", 0
menuPrompt3 db "(Enter 1) Play Game", 0
menuPrompt5   db "(Enter 3) Exit", 0
menuPrompt4 byte            "(Enter 2) Display instructions ", 0

menuMsg     BYTE "Enter your choice : ", 0
endstring db "Your score is : ",0
rollMsg     BYTE "Enter your roll number: ", 0
 pacManString1               db "/|||||  /||||||  /||||||      /|||      |||  /||||||| /|||       ||",0
 pacManString2               db "/|| ||  /||  ||  /||          /|| ||  || ||  /||   || /|| ||     ||",0
 pacManString3               db "/|| ||  /||  ||  /||          /||   ||   ||  /||   || /||  ||    ||",0
 pacManString4               db "/|| ||  /||  ||  /||          /||        ||  /||   || /||   ||   ||",0    
 pacManString5               db "/|||||  /||||||  /||          /||        ||  /||||||| /||    ||  ||",0
 pacManString6               db "/||     /||  ||  /||          /||        ||  /||   || /||     || ||",0
 pacManString7               db "/||     /||  ||  /||          /||        ||  /||   || /||      ||||",0
 pacManString8               db "/||     /||  ||  /||||||      /||        ||  /||   || /||        ||",0
 input db "Enter your choice : ",0
 insrtuctionsmsg             db " ====>>>> If you have read all the instructions press ( c ) to constinue to game : ",0
 vr byte 0
 ;////////// Displaying level1///////////////

ground BYTE "---------------",0
groundo byte "///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////",0
groundoo byte "///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////",0

groundo1 BYTE "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\",0
ground1 BYTE "|",0ah,0
ground2 BYTE "|",0
space1 byte " ",0
temp byte ?
walls byte "||",0
level1String1                 db 'L        EEEE  V   V  EEEE  L      111', 0
level1String2                 db 'L        E     V   V  E     L       1 ', 0
level1String3                 db 'L        EEE   V   V  EEE   L       1 ', 0
level1String4                 db 'L        E      V V   E     L       1 ', 0
level1String5                 db 'LLLLL    EEEE    V    EEEE  LLLL   111', 0

level2String1                 db 'L        EEEE  V   V  EEEE  L      2222', 0
level2String2                 db 'L        E     V   V  E     L        22 ', 0
level2String3                 db 'L        EEE   V   V  EEE   L      22 ', 0
level2String4                 db 'L        E      V V   E     L      22 ', 0
level2String5                 db 'LLLLL    EEEE    V    EEEE  LLLL   2222', 0

level3String1                 db 'L        EEEE  V   V  EEEE  L      3333', 0
level3String2                 db 'L        E     V   V  E     L         3', 0
level3String3                 db 'L        EEE   V   V  EEE   L      3333', 0
level3String4                 db 'L        E      V V   E     L         3', 0
level3String5                 db 'LLLLL    EEEE    V    EEEE  LLLL   3333', 0


var101 BYTE ?
var102 BYTE ?

 scoreString1                db ' SSS   CCC  OOO  RRRR   EEEE ', 0
 scoreString2                db ' S     C    O O  R  R   E     ', 0
 scoreString3                db ' SSS   C    O O  RRR    EEE   ', 0
 scoreString4                db '   S   C    O O  R R    E     ', 0
 scoreString5                db ' SSS   CCC  OOO  R  RR  EEEE  ', 0

strScore BYTE "Your score is: ",0
score dw 0
lifestring db "Lives remaining : ",0
swag BYTE 0

xPos BYTE 44
yPos BYTE 14

xCoinPos BYTE ?
yCoinPos BYTE ?

inputChar BYTE ?

.code
main PROC
 mov eax, offset file  ;; pszSound is a file name
 mov ebx, SND_FILENAME
 or ebx, SND_LOOP       ;; Play in a loop
 or ebx, SND_ASYNC      ;; Play in the background
 push ebx
 push 0
 push eax
 call PlaySound

call clrscr
mov eax,black(black*16)
call displayPacman
call clrscr
call displaymenu
call clrscr

ret
main ENDP



;////////////////////////           LEVEL - 1                 /////////////////////////////
level1 proc
    

 ; draw ground at (0,29):
    mov eax,blue ;(black * 16)
    call SetTextColor
    mov dl,0
    mov dh,28
    call Gotoxy
     mov edx,OFFSET groundoo
    call WriteString
    mov dl,119
    mov dh,28
    call Gotoxy
    mov edx,OFFSET groundo1
    call WriteString
   
    mov dl,0
    mov dh,1
    call Gotoxy
     mov edx,OFFSET ground
    call WriteString
    call Gotoxy
    mov dl,0
    mov dh,2
    call Gotoxy
    mov edx,OFFSET groundo
    call WriteString
       mov dl,120
    mov dh,2
    call Gotoxy
    mov edx,OFFSET groundo1
    call WriteString
    
    mov ecx,27
    mov dh,2
    mov temp,dh
    l1:
    mov dh,temp
    mov dl,0
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    loop l1


    mov esi,OFFSET x
    mov edi,OFFSET y
    mov ecx,10
    mov dh,8
    mov temp,dh
    l5:
    mov eax,red
    call SetTextColor
    mov dh,temp
    mov dl,7
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc edi
    inc esi
    loop l5

  

    mov ecx,15
    mov dl,97
    mov temp,dl
     l66:
    mov dl,temp
    mov dh,7
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc esi
    inc edi
    inc temp
    loop l66


    mov ecx,12
    mov dl,6
    mov dh,7
    mov temp,dh
     l7:
    mov dl,temp
    mov dh,7
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l7

    
 

    

    mov ecx,12
    mov dl,45
    mov temp,dl
     l8:
     
    mov dl,temp
    mov dh,7
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
 
 loop l8



    mov ecx,11
    mov dh,7
    mov temp,dh
 l9:
    mov eax,red
call SetTextColor
    mov dh,temp
    mov dl,56
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l9

  ;for vertical walls  
    mov ecx,11
    mov dh,7
    mov temp,dh
 l10:
    mov eax,red
call SetTextColor
    mov dh,temp
    mov dl,32
    mov [esi],dl
    mov [edi],dh
    call Gotoxy

    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l10

      mov ecx,9
    mov dl,28
    mov temp,dl
 l11:
    mov eax,red
call SetTextColor
    mov dl,temp
    mov dh,17
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l11


     ;for horizontal walls  
   
    mov ecx,9
    mov dl,75
    mov temp,dl
 l13:
    mov eax,red
call SetTextColor
    mov dl,temp
    mov dh,7
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l13

      mov ecx,10
    mov dh,8
    mov temp,dh
 l12:
    mov eax,red
call SetTextColor
    mov dh,temp
    mov dl,75
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc esi
    inc edi
    inc temp
    loop l12

    
      mov ecx,10
    mov dh,8
    mov temp,dh
 l14:
    mov eax,red
call SetTextColor
    mov dh,temp
    mov dl,111
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l14
   
   
    mov ecx, 103
    mov dl,8
    mov temp,dl
 l15:
    mov eax,red
call SetTextColor
    mov dl,temp
    mov dh,22
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l15


    mov dl,128
    mov dh,4

    call Gotoxy
     mov edx,OFFSET level1String1 
    call WriteString

     mov dl,128
    mov dh,5

    call Gotoxy
     mov edx,OFFSET level1String2 
    call WriteString
     mov dl,128
    mov dh,6

    call Gotoxy
     mov edx,OFFSET level1String3 
    call WriteString
     mov dl,128
    mov dh,7

    call Gotoxy
     mov edx,OFFSET level1String4 
    call WriteString
     mov dl,128
    mov dh,8

    call Gotoxy
     mov edx,OFFSET level1String5 
    call WriteString



    mov ecx,27
    mov dh,2
    mov temp,dh
    l2:
    mov eax,blue
    call SetTextColor
    mov dh,temp
    mov dl,119
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l2

    ;//////////////Drawing coins/////////////
    ;for vertical food  
    mov esi,OFFSET xcoins
    mov edi,OFFSET ycoins
    mov ecx,16
    mov dh,5
    mov temp,dh
    
    mov bl,0
    mov inc1,bl
    
 l100:
    mov eax,green
    call SetTextColor
    mov dh,temp
    mov dl,40

    mov [edi],dh
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc edi
    loop l100

    mov ecx,16
    mov [esi],dl
  ll:
    mov  [esi],dl
    inc esi
    inc inc1
    loop ll

    mov ecx,16
    mov dh,5
    mov temp,dh
    
    l101:
    mov eax,green
    call SetTextColor
    mov dh,temp
    mov dl,70

    mov [edi],dh
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc edi
    loop l101
  
  mov ecx,16
  mov [esi],dl
 ll1:
  mov  [esi],dl
  inc esi
  inc inc1
  loop ll1


    mov ecx,16
    mov dh,5
    mov temp,dh
    
 l102:
    mov eax,green
    call SetTextColor
    mov dh,temp
    mov dl,92

    mov [edi],dh
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc edi
    loop l102
    mov ecx,16
    mov [esi],dl
 ll2:
    mov  [esi],dl
    inc inc1
    inc esi
  
    loop ll2


  
    mov ecx,16
    mov dh,5
    mov temp,dh
    
 l103:
    mov eax,green
    call SetTextColor
    mov dh,temp
    mov dl,23

    mov [edi],dh
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc edi
    loop l103
    mov ecx,16
    mov [esi],dl
 ll3:
    mov  [esi],dl
    inc inc1
    inc esi
  
    loop ll3



    
    ;           //////////////////
    call DrawPlayer

     
     mov ebp,0

    gameLoop:


    cmp ebp,1
    jne skipping
        mov eax,green
    call SetTextColor
        mov dl,var101
    mov dh,var102
    call Gotoxy
    mov edx, OFFSET var
    call WriteString
    mov ebp,0


    skipping:

   
   mov esi,offset xcoins
        mov edi,offset ycoins
        mov esi,offset xcoins
        mov ecx,lengthof ycoins
     y45:
        mov al,[esi]
        mov ah,[edi]
        cmp xghost,al
        jne noinc1
        

        movex:
        cmp yghost,ah
        jne noinc1

        mov ebp,1

       mov var101,al
       mov var102,ah

       jmp loopexit

        noinc1:
        inc esi
        inc edi

              loop y45

    loopexit:
        


   ;implemeting ghost logics    
;1st ghost
        cmp swag,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello
         
        cmp yghost1,21
        je hello
        call UpdateGhost1
        inc yghost1
        call DrawGhost1
        
        jmp swoop


        hello:
        mov swag,1
        call UpdateGhost1
        dec yghost1
        call DrawGhost1 
        cmp yghost1,3
        jne swoop
        mov swag,0
                

;2nd ghost        

        swoop:
        cmp swag1,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello1
         
        cmp xghost,118
        je hello1
        call UpdateGhost
        inc xghost
        call DrawGhost
        
        jmp swoop1


        hello1:
        mov swag1,1
        call UpdateGhost
        dec xghost
        call DrawGhost 
        cmp xghost,2
        jne swoop1
        mov swag1,0

        swoop1:
;3rd ghost

        cmp swag2,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello2
         
        cmp yghost2,21
        je hello2
        call UpdateGhost2
        inc yghost2
        call DrawGhost2
        
        jmp swoop2


        hello2:
        mov swag2,1
        call UpdateGhost2
        dec yghost2
        call DrawGhost2 
        cmp yghost2,3
        jne swoop2
        mov swag2,0


        swoop2:
;4th ghost
        
        cmp swag3,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello3
         
        cmp yghost3,21
        je hello3
        call UpdateGhost3
        inc yghost3
        call DrawGhost3
        
        jmp swoop3


        hello3:
        mov swag3,1
        call UpdateGhost3
        dec yghost3
        call DrawGhost3
        cmp yghost3,3
        jne swoop3
        mov swag3,0

        swoop3:
        
;//////////// checking collision of ghost with player  /////////////////////
       
        mov bl,xPos
        cmp bl,xghost1
        je checky
        cmp bl,xghost
        je checky
        cmp bl,xghost2
        je checky
        cmp bl,xghost3
        je checky
        jne nodec

        checky:
        mov al,yPos
        cmp al,yghost1
        je declife
        cmp al,yghost
        je declife
        cmp al,yghost2
        je declife
        cmp al,yghost3
        je declife

        jne nodec
        declife:
        dec life
        mov xPos,44
        mov yPos,14
        cmp life,0
        je exitGame

        call UpdatePlayer
        call DrawPlayer
         nodec:
         ;///////////score/////
        mov esi,offset xcoins
        mov edi,offset ycoins
        mov ecx,lengthof ycoins
     y44:
        mov al,[esi]
        mov ah,[edi]
        cmp xPos,al
        je checkx22
        jmp noinc

        checkx22:
        cmp yPos,ah
        JE GiveIncrementInScore
        jne noinc
       GiveIncrementInScore:
        inc score
        cmp score,64
        je movetolevel2
        jne movetolevel1

        movetolevel2:
        dec score
        call level2
        movetolevel1:
        mov al,-5
        mov ah,-8
        mov [esi],al
        mov [edi],ah
    
        noinc:
        inc esi
        inc edi

              loop y44

      
        mov eax,white (black * 16)
        call SetTextColor

        ; draw score:
         mov eax,yellow
        call SetTextColor
        mov dl,128
        mov dh,13
        call Gotoxy
        mov edx,OFFSET scoreString1
        call WriteString

         mov dl,128
        mov dh,14
        call Gotoxy
        mov edx,OFFSET scoreString2
        call WriteString
         mov dl,128
        mov dh,15
        call Gotoxy
        mov edx,OFFSET scoreString3
        call WriteString
         mov dl,128
        mov dh,16
        call Gotoxy
        mov edx,OFFSET scoreString4
        call WriteString
         mov dl,128
        mov dh,17
        call Gotoxy
        mov edx,OFFSET scoreString5
        call WriteString
        

        mov dl,128
        mov dh,20
        call gotoxy
        mov ax,score                              ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        call Writedec

        mov dl,128
        mov dh,23
        call gotoxy
        mwrite "Name of player : "
        mov edx, OFFSET menuPrompt1
        call WriteString
        call crlf

        mov dl,128
        mov dh,26
        call gotoxy
        mov edx,OFFSET lifestring
        call WriteString
        mov ax,life                             ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        call Writedec



        ; gravity logic:
        ;gravity:
        ;cmp yPos,27
        ;jg onGround
        ; make player fall:
        ;call UpdatePlayer
        ;inc yPos
        ;call DrawPlayer
        ;mov eax,80
        ;call Delay
        ;jmp gravity
        onGround:

        mov eax,70
        call delay

        ; get user key input:
        call Readkey
        mov inputChar,al

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame

        cmp inputChar,"w"
        je moveUp

        

        cmp inputChar,"s"
        je moveDown

        cmp inputChar,"a"
        je moveLeft

        cmp inputChar,"d"
        je moveRight

        cmp inputChar , "p"
        je pauseee

        jmp gameloop


        pauseee:
        call readchar

        jmp gameLoop
        
        moveUp:
        cmp yPos,3
        je gameloop
         mov ecx,lengthof y
        mov esi,offset x
        mov edi,offset y
        y2:
        mov al,[esi]
        mov bl,[edi]
        add bl,1
        cmp yPos,bl

        je checkx
        jne increment
        checkx:
        cmp xPos,al
        je gameloop
        increment:
        inc esi
        inc edi
        loop y2
        ; allow player to jump:
        mov ecx,1
        jumpLoop:
            call UpdatePlayer
            dec yPos
            call DrawPlayer
            mov eax,70
            call Delay
        loop jumpLoop
        jmp gameLoop

        moveDown:
        cmp yPos,27
        je gameloop
        mov ecx,lengthof y
        mov esi,offset x
        mov edi,offset y
        y1:
        mov al,[esi]
        mov bl,[edi]
        sub bl,1
        cmp yPos,bl
        je checkx1
       
        jne increment1
        checkx1:
        cmp xPos,al
        je gameloop
        
        increment1:
        inc esi
        inc edi
        loop y1

        call UpdatePlayer
        inc yPos
        call DrawPlayer
        jmp gameLoop

        moveLeft:
        cmp xPos,1
        je gameloop
        mov ecx,lengthof y
        mov esi,offset x
        mov edi,offset y
        y3:
        mov al,[esi]
        mov bl,[edi]
        cmp yPos,bl

        je checkx2
        jne increment3
        checkx2:
        add al,1
        cmp xPos,al
        je gameloop
        increment3:
        inc esi
        inc edi
        loop y3

        call UpdatePlayer
        dec xPos
        call DrawPlayer
        jmp gameLoop

        moveRight:
        cmp xPos,118
        je gameloop
         mov ecx,lengthof y
        mov esi,offset x
        mov edi,offset y
        y4:
        mov al,[esi]
        mov bl,[edi]
        cmp yPos,bl

        je checkx4
        jne increment4
        checkx4:
        sub al,1
        cmp xPos,al
        je gameloop
        increment4:
        inc esi
        inc edi
        loop y4
        call UpdatePlayer
        inc xPos
        call DrawPlayer
        jmp gameLoop



    jmp gameLoop

    exitGame:
    call clrscr
    call endmenu
    exit
ret
level1 endp

;////////////////////////////////////End-level1??????????????????????????????????????
;////////////////////////           LEVEL - 2              /////////////////////////////
level2 proc
    
    mov xPos,44
    mov yPos,14
    call  UpdatePlayer
    call DrawPlayer

   ; draw ground at (0,29):
    mov eax,black(white * 16)
    call SetTextColor
    mov dl,0
    mov dh,28
    call Gotoxy
     mov edx,OFFSET groundoo
    call WriteString
    mov dl,119
    mov dh,28
    call Gotoxy
    mov edx,OFFSET groundo1
    call WriteString
   
    mov dl,0
    mov dh,1
    call Gotoxy
     mov edx,OFFSET ground
    call WriteString
    call Gotoxy
    mov dl,0
    mov dh,2
    call Gotoxy
    mov edx,OFFSET groundo
    call WriteString
       mov dl,120
    mov dh,2
    call Gotoxy
    mov edx,OFFSET groundo1
    call WriteString
    
    mov ecx,27
    mov dh,2
    mov temp,dh
    l1:
    mov dh,temp
    mov dl,0
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    loop l1


    mov esi,OFFSET x
    mov edi,OFFSET y
    mov ecx,10
    mov dh,8
    mov temp,dh
    l5:
    mov eax,black(white * 16)
    call SetTextColor
    mov dh,temp
    mov dl,7
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc edi
    inc esi
    loop l5

  

    mov ecx,15
    mov dl,97
    mov temp,dl
     l66:
    mov dl,temp
    mov dh,7
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc esi
    inc edi
    inc temp
    loop l66


    mov ecx,12
    mov dl,6
    mov dh,7
    mov temp,dh
     l7:
    mov dl,temp
    mov dh,7
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l7

    
 

    

    mov ecx,12
    mov dl,45
    mov temp,dl
     l8:
     
    mov dl,temp
    mov dh,7
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
 
 loop l8



    mov ecx,11
    mov dh,7
    mov temp,dh
 l9:
    mov eax,black(white * 16)
    call SetTextColor
    mov dh,temp
    mov dl,56
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l9

  ;for vertical walls  
    mov ecx,11
    mov dh,7
    mov temp,dh
 l10:
     mov eax,black(white * 16)
    call SetTextColor
    mov dh,temp
    mov dl,32
    mov [esi],dl
    mov [edi],dh
    call Gotoxy

    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l10

      mov ecx,9
    mov dl,28
    mov temp,dl
 l11:
    mov eax,black(white * 16)
    call SetTextColor
    mov dl,temp
    mov dh,17
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l11


     ;for horizontal walls  
   
    mov ecx,9
    mov dl,75
    mov temp,dl
 l13:
     mov eax,black(white * 16)
    call SetTextColor
    mov dl,temp
    mov dh,7
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l13

      mov ecx,10
    mov dh,8
    mov temp,dh
 l12:
    mov eax,black(white * 16)
    call SetTextColor
    mov dh,temp
    mov dl,75
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc esi
    inc edi
    inc temp
    loop l12

    
      mov ecx,10
    mov dh,8
    mov temp,dh
 l14:
     mov eax,black(white * 16)
    call SetTextColor
    mov dh,temp
    mov dl,111
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l14
   
   
    mov ecx, 103
    mov dl,8
    mov temp,dl
 l15:
     mov eax,black(white * 16)
    call SetTextColor
    mov dl,temp
    mov dh,22
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l15

    mov ecx, 103
    mov dl,8
    mov temp,dl
 l16:
     mov eax,black(white * 16)
    call SetTextColor
    mov dl,temp
    mov dh,4
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l16

    
    mov eax,white (black * 16)
    call SetTextColor
    mov dl,128
    mov dh,4

    call Gotoxy
     mov edx,OFFSET level2String1 
    call WriteString

     mov dl,128
    mov dh,5

    call Gotoxy
     mov edx,OFFSET level2String2 
    call WriteString
     mov dl,128
    mov dh,6

    call Gotoxy
     mov edx,OFFSET level2String3 
    call WriteString
     mov dl,128
    mov dh,7

    call Gotoxy
     mov edx,OFFSET level2String4 
    call WriteString
     mov dl,128
    mov dh,8

    call Gotoxy
     mov edx,OFFSET level2String5 
    call WriteString



    mov ecx,27
    mov dh,2
    mov temp,dh
    l2:
     mov eax,black(white * 16)
    call SetTextColor
    mov dh,temp
    mov dl,119
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l2

    ;//////////////Drawing coins/////////////
    ;for vertical food  
    mov esi,OFFSET xcoins
    mov edi,OFFSET ycoins
    mov ecx,16
    mov dh,5
    mov temp,dh
    
    mov bl,0
    mov inc1,bl
    
 l100:
    mov eax,green
    call SetTextColor
    mov dh,temp
    mov dl,40

    mov [edi],dh
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc edi
    loop l100

    mov ecx,16
    mov [esi],dl
  ll:
    mov  [esi],dl
    inc esi
    inc inc1
    loop ll

    mov ecx,16
    mov dh,5
    mov temp,dh
    
    l101:
    mov eax,green
    call SetTextColor
    mov dh,temp
    mov dl,70

    mov [edi],dh
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc edi
    loop l101
  
  mov ecx,16
  mov [esi],dl
 ll1:
  mov  [esi],dl
  inc esi
  inc inc1
  loop ll1


    mov ecx,16
    mov dh,5
    mov temp,dh
    
 l102:
    mov eax,green
    call SetTextColor
    mov dh,temp
    mov dl,92

    mov [edi],dh
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc edi
    loop l102
    mov ecx,16
    mov [esi],dl
 ll2:
    mov  [esi],dl
    inc inc1
    inc esi
  
    loop ll2


  
    mov ecx,16
    mov dh,5
    mov temp,dh
    
 l103:
    mov eax,green
    call SetTextColor
    mov dh,temp
    mov dl,23

    mov [edi],dh
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc edi
    loop l103
    mov ecx,16
    mov [esi],dl
 ll3:
    mov  [esi],dl
    inc inc1
    inc esi
  
    loop ll3

    mov ecx,16
    mov dl,45
    mov temp,dl
    
 l104:
    mov eax,green
    call SetTextColor
    mov dl,temp
    mov dh,3

    mov [esi],dl
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc esi
    loop l104

    mov ecx,16
    mov [edi],dh
  ll4:
    mov  [edi],dh
    inc edi
    inc inc1
    loop ll4

    mov ecx,16
    mov dl,29   
    mov temp,dl
    
 l105:
    mov eax,green
    call SetTextColor
    mov dl,temp
    mov dh,24

    mov [esi],dl
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc esi
    loop l105

    mov ecx,16
    mov [edi],dh
  ll5:
    mov  [edi],dh
    inc edi
    inc inc1
    loop ll5

    mov ecx,16
    mov dl,47
    mov temp,dl
    
 l106:
    mov eax,green
    call SetTextColor
    mov dl,temp
    mov dh,24

    mov [esi],dl
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc esi
    loop l106

    mov ecx,16
    mov [edi],dh
  ll6:
    mov  [edi],dh
    inc edi
    inc inc1
    loop ll6

     mov ecx,16
    mov dl,65
    mov temp,dl
    
 l107:
    mov eax,green
    call SetTextColor
    mov dl,temp
    mov dh,24

    mov [esi],dl
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc esi
    loop l107

    mov ecx,16
    mov [edi],dh
  ll7:
    mov  [edi],dh
    inc edi
    inc inc1
    loop ll7

  
  
;//////////drawing coins for extra score ////

mov esi,offset xextra
mov edi,offset yextra
mov dl,15
mov temp,dl
mov ecx,2
lextra:
    mov eax,green
    call SetTextColor
    mov dl,temp
    mov dh,3

    mov [esi],dl
    
    call Gotoxy
    mwrite "#"
  
    inc temp
    inc esi
    loop lextra

    mov ecx,2
    mov [edi],dh
  llextra:
    mov  [edi],dh
    inc edi
    loop llextra

mov dl,4
mov temp,dl
mov ecx,2
lextra1:
    mov eax,green
    call SetTextColor
    mov dl,temp
    mov dh,20

    mov [esi],dl
    
    call Gotoxy
    mwrite "#"
  
    inc temp
    inc esi
    loop lextra1

    mov ecx,2
    mov [edi],dh
  llextra1:
    mov  [edi],dh
    inc edi
    loop llextra1


    
    ;           //////////////////



    
    ;           //////////////////
    call DrawPlayer

     
     mov ebp,0

    gameLoop:

    cmp ebp,1
    jne skipping
        mov eax,green
    call SetTextColor
        mov dl,var101
    mov dh,var102
    call Gotoxy
    mov edx, OFFSET var
    call WriteString
    mov ebp,0




    skipping:

   
   mov esi,offset xcoins
        mov edi,offset ycoins
        mov esi,offset xcoins
        mov ecx,lengthof ycoins
     y45:
        mov al,[esi]
        mov ah,[edi]
        cmp xghost,al
        jne noinc1
        

        movex:
        cmp yghost,ah
        jne noinc1

        mov ebp,1

       mov var101,al
       mov var102,ah

       jmp loopexit

        noinc1:
        inc esi
        inc edi

              loop y45

    loopexit:
        


   ;implemeting ghost logics    
     ;1st ghost
        cmp swag,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello
         
        cmp yghost1,21
        je hello
        call UpdateGhost1
        inc yghost1
        call DrawGhost1
        
        jmp swoop


        hello:
        mov swag,1
        call UpdateGhost1
        dec yghost1
        call DrawGhost1 
        cmp yghost1,6
        jne swoop
        mov swag,0
                

;2nd ghost        

        swoop:
        cmp swag1,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello1
         
        cmp xghost,118
        je hello1
        call UpdateGhost
        inc xghost
        call DrawGhost
        
        jmp swoop1


        hello1:
        mov swag1,1
        call UpdateGhost
        dec xghost
        call DrawGhost 
        cmp xghost,2
        jne swoop1
        mov swag1,0

        swoop1:
;3rd ghost

        cmp swag2,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello2
         
        cmp yghost2,21
        je hello2
        call UpdateGhost2
        inc yghost2
        call DrawGhost2
        
        jmp swoop2


        hello2:
        mov swag2,1
        call UpdateGhost2
        dec yghost2
        call DrawGhost2 
        cmp yghost2,6
        jne swoop2
        mov swag2,0


        swoop2:
;4th ghost
        
        cmp swag3,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello3
         
        cmp yghost3,21
        je hello3
        call UpdateGhost3
        inc yghost3
        call DrawGhost3
        
        jmp swoop3


        hello3:
        mov swag3,1
        call UpdateGhost3
        dec yghost3
        call DrawGhost3
        cmp yghost3,6
        jne swoop3
        mov swag3,0

        swoop3:
;ghost5
        cmp swag4,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello4
         
        cmp xghost4,1
        je hello4
        call UpdateGhost4
        dec  xghost4
        call DrawGhost4
        
        jmp swoop4


        hello4:
        mov swag4,1
        call UpdateGhost4
        inc xghost4
        call DrawGhost4
        cmp xghost4,7
        jne swoop4
        mov swag4,0


        swoop4:
;ghost6
        cmp swag5,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello5
         
        cmp xghost5,111
        je hello5
        call UpdateGhost5
        dec  xghost5
        call DrawGhost5
        
        jmp swoop5


        hello5:
        mov swag5,1
        call UpdateGhost5
        inc xghost5
        call DrawGhost5
        cmp xghost5,118
        jne swoop5
        mov swag5,0

        swoop5:

        cmp swag6,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello6
         
        cmp yghost6,23
        je hello6
        call UpdateGhost6
        dec  yghost6
        call DrawGhost6
        
        jmp swoop6


        hello6:
        mov swag6,1
        call UpdateGhost6
        inc yghost6
        call DrawGhost6
        cmp yghost6,27
        jne swoop6
        mov swag6,0

        swoop6:
;ghost 7

        cmp swag7,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello7
         
        cmp yghost7,23
        je hello7
        call UpdateGhost7
        dec  yghost7
        call DrawGhost7
        
        jmp swoop7


        hello7:
        mov swag7,1
        call UpdateGhost7
        inc yghost7
        call DrawGhost7
        cmp yghost7,27
        jne swoop7
        mov swag7,0

        swoop7:       
;//////////// checking collision of ghost with player  /////////////////////
       
        mov bl,xPos
        cmp bl,xghost1
        je checky1
        cmp bl,xghost
        je checky2
        cmp bl,xghost2
        je checky3
        cmp bl,xghost3
        je checky4
        cmp bl,xghost4
        je checky5
        cmp bl,xghost5
        je checky6
        cmp bl,xghost6
        je checky7
       cmp bl,xghost7
        je checky8

        jne nodec

        checky1:
       
        mov al,yPos
        cmp al,yghost1
        je declife
         jne nodec

        checky2:
         mov al,yPos
        cmp al,yghost
        je declife
         jne nodec

        checky3:
        mov al,yPos
        cmp al,yghost2
        je declife
         jne nodec

        checky4:
        mov al,yPos
        cmp al,yghost3
        je declife
         jne nodec

        checky5:
        mov al,yPos
        cmp al,yghost4
        je declife
        jne nodec


        checky6:
        mov al,yPos
        cmp al,yghost5
        je declife
        jne nodec

        checky7:
        mov al,yPos
        cmp al,yghost6
        je declife
        jne nodec

         checky8:
        mov al,yPos
        cmp al,yghost7
        je declife
        


        jne nodec
        declife:
        dec life
        mov xPos,44
        mov yPos,14
        cmp life,0
        je exitGame

        call UpdatePlayer
        call DrawPlayer
         nodec:
         ;///////////score/////
        mov esi,offset xcoins
        mov edi,offset ycoins
        mov ecx,lengthof ycoins
     y44:
        mov al,[esi]
        mov ah,[edi]
        cmp xPos,al
        je checkx22
        jmp noinc

        checkx22:
        cmp yPos,ah
        JE GiveIncrementInScore
        jne noinc
       GiveIncrementInScore:
        inc score
        cmp score,191
        je movetolevel3
        jne movetolevel2

        movetolevel3:
        inc score
        call level3
        movetolevel2:
        mov al,-5
        mov ah,-8
        mov [esi],al
        mov [edi],ah

        noinc:
        inc esi
        inc edi

              loop y44
      
       
        mov esi,offset xextra
        mov edi,offset yextra
        mov ecx,lengthof yextra
     ylife:
        mov al,[esi]
        mov ah,[edi]
        cmp xPos,al
        je checkx222
        jmp noincc

        checkx222:
        cmp yPos,ah
        JE GiveIncrementInScore1
        jne noincc
       GiveIncrementInScore1:
        add life,1
        mov al,-5
        mov ah,-8
        mov [esi],al
        mov [edi],ah
    
        noincc:
        inc esi
        inc edi

              loop ylife
      
        mov eax,white (black * 16)
        call SetTextColor

        ; draw score:
         mov eax,yellow
        call SetTextColor
        mov dl,128
        mov dh,13
        call Gotoxy
        mov edx,OFFSET scoreString1
        call WriteString

         mov dl,128
        mov dh,14
        call Gotoxy
        mov edx,OFFSET scoreString2
        call WriteString
         mov dl,128
        mov dh,15
        call Gotoxy
        mov edx,OFFSET scoreString3
        call WriteString
         mov dl,128
        mov dh,16
        call Gotoxy
        mov edx,OFFSET scoreString4
        call WriteString
         mov dl,128
        mov dh,17
        call Gotoxy
        mov edx,OFFSET scoreString5
        call WriteString
        

        mov dl,128
        mov dh,20
        call gotoxy
        mov ax,score                              ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        call Writedec

        mov dl,128
        mov dh,23
        call gotoxy
        mwrite "Name of player : "
        mov edx, OFFSET menuPrompt1
        call WriteString
        call crlf

        mov dl,128
        mov dh,26
        call gotoxy
        mov edx,OFFSET lifestring
        call WriteString
        mov ax,life                             
        call Writedec



        ; gravity logic:
        ;gravity:
        ;cmp yPos,27
        ;jg onGround
        ; make player fall:
        ;call UpdatePlayer
        ;inc yPos
        ;call DrawPlayer
        ;mov eax,80
        ;call Delay
        ;jmp gravity
        onGround:

        mov eax,70
        call delay

        ; get user key input:
        call Readkey
        mov inputChar,al

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame
       

        cmp inputChar,"w"
        je moveUp

        cmp inputChar,"s"
        je moveDown

        cmp inputChar,"a"
        je moveLeft

        cmp inputChar,"d"
        je moveRight
        cmp inputChar , "p"
        je pauseee

        jmp gameloop


        pauseee:
        call readchar
        jmp gameLoop

        moveUp:
        cmp yPos,3
        je gameloop
         mov ecx,lengthof y
        mov esi,offset x
        mov edi,offset y
        y2:
        mov al,[esi]
        mov bl,[edi]
        add bl,1
        cmp yPos,bl

        je checkx
        jne increment
        checkx:
        cmp xPos,al
        je gameloop
        increment:
        inc esi
        inc edi
        loop y2
        ; allow player to jump:
        mov ecx,1
        jumpLoop:
            call UpdatePlayer
            dec yPos
            call DrawPlayer
            mov eax,70
            call Delay
        loop jumpLoop
        jmp gameLoop

        moveDown:
        cmp yPos,27
        je gameloop
        mov ecx,lengthof y
        mov esi,offset x
        mov edi,offset y
        y1:
        mov al,[esi]
        mov bl,[edi]
        sub bl,1
        cmp yPos,bl
        je checkx1
       
        jne increment1
        checkx1:
        cmp xPos,al
        je gameloop
        
        increment1:
        inc esi
        inc edi
        loop y1

        call UpdatePlayer
        inc yPos
        call DrawPlayer
        jmp gameLoop

        moveLeft:
        cmp xPos,1
        je gameloop
        mov ecx,lengthof y
        mov esi,offset x
        mov edi,offset y
        y3:
        mov al,[esi]
        mov bl,[edi]
        cmp yPos,bl

        je checkx2
        jne increment3
        checkx2:
        add al,1
        cmp xPos,al
        je gameloop
        increment3:
        inc esi
        inc edi
        loop y3

        call UpdatePlayer
        dec xPos
        call DrawPlayer
        jmp gameLoop

        moveRight:
        cmp xPos,118
        je gameloop
         mov ecx,lengthof y
        mov esi,offset x
        mov edi,offset y
        y4:
        mov al,[esi]
        mov bl,[edi]
        cmp yPos,bl

        je checkx4
        jne increment4
        checkx4:
        sub al,1
        cmp xPos,al
        je gameloop
        increment4:
        inc esi
        inc edi
        loop y4
        call UpdatePlayer
        inc xPos
        call DrawPlayer
        jmp gameLoop



    jmp gameLoop

    exitGame:
    call clrscr
    call endmenu
    exit
ret
level2 endp


;////////////////////////////////////////////




;////////////////////////           LEVEL - 3             /////////////////////////////
level3 proc
    mov xPos,44
    mov yPos,14
    call UpdatePlayer
            call DrawPlayer

   ; draw ground at (0,29):
    mov eax,black(brown * 16)
    call SetTextColor
    mov dl,0
    mov dh,28
    call Gotoxy
    mov edx,OFFSET groundoo
    call WriteString
    mov dl,119
    mov dh,28
    call Gotoxy
    mov edx,OFFSET groundo1
    call WriteString
    
    mov dl,0
    mov dh,2
    call Gotoxy
    mov edx,OFFSET groundo
    call WriteString
    mov dl,120
    mov dh,2
    call Gotoxy
    mov edx,OFFSET groundo1
    call WriteString
    
    mov esi,OFFSET x
    mov edi,OFFSET y
    mov ecx,25
    mov dh,2
    mov temp,dh
    l1:
    mov dh,temp
    mov dl,0
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
     inc edi
    inc esi
    loop l1

    mov ecx,24
    mov dh,4
    mov temp,dh
    l2:
     mov eax,black(brown * 16)
    call SetTextColor
    mov dh,temp
    mov dl,119
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l2
    
    mov ecx,10
    mov dh,8
    mov temp,dh
    l5:
   mov eax,black(brown * 16)
    call SetTextColor
    mov dh,temp
    mov dl,7
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc edi
    inc esi
    loop l5

  

    mov ecx,15
    mov dl,97
    mov temp,dl
     l66:
    mov dl,temp
    mov dh,7
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc esi
    inc edi
    inc temp
    loop l66


    mov ecx,12
    mov dl,6
    mov dh,7
    mov temp,dh
     l7:
    mov dl,temp
    mov dh,7
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l7

    
 

    

    mov ecx,12
    mov dl,45
    mov temp,dl
     l8:
     
    mov dl,temp
    mov dh,7
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
 
 loop l8



    mov ecx,11
    mov dh,7
    mov temp,dh
 l9:
    mov eax,black(brown * 16)
    call SetTextColor
    mov dh,temp
    mov dl,56
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l9

  ;for vertical walls  
    mov ecx,11
    mov dh,7
    mov temp,dh
 l10:
     mov eax,black(brown * 16)
    call SetTextColor
    mov dh,temp
    mov dl,32
    mov [esi],dl
    mov [edi],dh
    call Gotoxy

    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l10

      mov ecx,9
    mov dl,28
    mov temp,dl
 l11:
    mov eax,black(brown * 16)
    call SetTextColor
    mov dl,temp
    mov dh,17
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l11


     ;for horizontal walls  
   
    mov ecx,9
    mov dl,75
    mov temp,dl
 l13:
     mov eax,black(brown * 16)
    call SetTextColor
    mov dl,temp
    mov dh,7
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l13

      mov ecx,10
    mov dh,8
    mov temp,dh
 l12:
    mov eax,black(brown * 16)
    call SetTextColor
    mov dh,temp
    mov dl,75
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc esi
    inc edi
    inc temp
    loop l12

    
      mov ecx,10
    mov dh,8
    mov temp,dh
 l14:
    mov eax,black(brown * 16)
    call SetTextColor
    mov dh,temp
    mov dl,111
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l14
   
   
    mov ecx, 103
    mov dl,8
    mov temp,dl
 l15:
     mov eax,black(brown * 16)
    call SetTextColor
    mov dl,temp
    mov dh,22
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l15

    mov ecx, 103
    mov dl,8
    mov temp,dl
 l16:
     mov eax,black(brown * 16)
    call SetTextColor
    mov dl,temp
    mov dh,4
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l16

    
    mov ecx,4
    mov dh,22
    mov temp,dh
 l17:
     mov eax,black(brown * 16)
    call SetTextColor
    mov dh,temp
    mov dl,18
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l17
   
    mov ecx,4
    mov dh,22
    mov temp,dh
 l18:
     mov eax,black(brown * 16)
    call SetTextColor
    mov dh,temp
    mov dl,86
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l18
   
    mov ecx,18
    mov dl,28
    mov temp,dl
 l19:
     mov eax,black(brown * 16)
    call SetTextColor
    mov dl,temp
    mov dh,25
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l19

    mov ecx,17
    mov dl,47
    mov temp,dl
 l20:
     mov eax,black(brown * 16)
    call SetTextColor
    mov dl,temp
    mov dh,25
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l20

     mov ecx,17
    mov dl,65
    mov temp,dl
 l21:
     mov eax,black(brown * 16)
    call SetTextColor
    mov dl,temp
    mov dh,25
    mov [esi],dl
    mov [edi],dh
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    inc esi
    inc edi
    loop l21

    
    mov eax,white (black * 16)
    call SetTextColor
    mov dl,128
    mov dh,4

    call Gotoxy
    mov edx,OFFSET level3String1 
    call WriteString

     mov dl,128
    mov dh,5

    call Gotoxy
     mov edx,OFFSET level3String2 
    call WriteString
     mov dl,128
    mov dh,6

    call Gotoxy
     mov edx,OFFSET level3String3 
    call WriteString
     mov dl,128
    mov dh,7

    call Gotoxy
     mov edx,OFFSET level3String4 
    call WriteString
     mov dl,128
    mov dh,8

    call Gotoxy
     mov edx,OFFSET level3String5 
    call WriteString


    ;//////////////Drawing coins/////////////
    ;for vertical food  
    mov esi,OFFSET xcoins
    mov edi,OFFSET ycoins
    mov ecx,16
    mov dh,5
    mov temp,dh
    
    mov bl,0
    mov inc1,bl
    
 l100:
    mov eax,green
    call SetTextColor
    mov dh,temp
    mov dl,40

    mov [edi],dh
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc edi
    loop l100

    mov ecx,16
    mov [esi],dl
  ll:
    mov  [esi],dl
    inc esi
    inc inc1
    loop ll

    mov ecx,16
    mov dh,5
    mov temp,dh
    
    l101:
    mov eax,green
    call SetTextColor
    mov dh,temp
    mov dl,70

    mov [edi],dh
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc edi
    loop l101
  
  mov ecx,16
  mov [esi],dl
 ll1:
  mov  [esi],dl
  inc esi
  inc inc1
  loop ll1


    mov ecx,16
    mov dh,5
    mov temp,dh
    
 l102:
    mov eax,green
    call SetTextColor
    mov dh,temp
    mov dl,92

    mov [edi],dh
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc edi
    loop l102
    mov ecx,16
    mov [esi],dl
 ll2:
    mov  [esi],dl
    inc inc1
    inc esi
  
    loop ll2


  
    mov ecx,16
    mov dh,5
    mov temp,dh
    
 l103:
    mov eax,green
    call SetTextColor
    mov dh,temp
    mov dl,23

    mov [edi],dh
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc edi
    loop l103
    mov ecx,16
    mov [esi],dl
 ll3:
    mov  [esi],dl
    inc inc1
    inc esi
  
    loop ll3

    mov ecx,16
    mov dl,45
    mov temp,dl
    
 l104:
    mov eax,green
    call SetTextColor
    mov dl,temp
    mov dh,3

    mov [esi],dl
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc esi
    loop l104

    mov ecx,16
    mov [edi],dh
  ll4:
    mov  [edi],dh
    inc edi
    inc inc1
    loop ll4

    mov ecx,16
    mov dl,29   
    mov temp,dl
    
 l105:
    mov eax,green
    call SetTextColor
    mov dl,temp
    mov dh,24

    mov [esi],dl
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc esi
    loop l105

    mov ecx,16
    mov [edi],dh
  ll5:
    mov  [edi],dh
    inc edi
    inc inc1
    loop ll5

    mov ecx,17
    mov dl,47
    mov temp,dl
    
 l106:
    mov eax,green
    call SetTextColor
    mov dl,temp
    mov dh,24

    mov [esi],dl
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc esi
    loop l106

    mov ecx,16
    mov [edi],dh
  ll6:
    mov  [edi],dh
    inc edi
    inc inc1
    loop ll6

     mov ecx,17
    mov dl,65
    mov temp,dl
    
 l107:
    mov eax,green
    call SetTextColor
    mov dl,temp
    mov dh,24

    mov [esi],dl
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc esi
    loop l107

    mov ecx,16
    mov [edi],dh
  ll7:
    mov  [edi],dh
    inc edi
    inc inc1
    loop ll7

    mov ecx,16
    mov dl,29
    mov temp,dl
    
    l108:
    mov eax,green
    call SetTextColor
    mov dl,temp
    mov dh,26

    mov [esi],dl
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc esi
    loop l108

    mov ecx,16
    mov [edi],dh
  ll8:
    mov  [edi],dh
    inc edi
    inc inc1
    loop ll8

    

    mov ecx,16
    mov dl,48
    mov temp,dl
    
    l109:
    mov eax,green
    call SetTextColor
    mov dl,temp
    mov dh,26

    mov [esi],dl
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc esi
    loop l109

    mov ecx,16
    mov [edi],dh
  ll9:
    mov  [edi],dh
    inc edi
    inc inc1
    loop ll9

    mov ecx,16
    mov dl,66
    mov temp,dl
    
    l110:
    mov eax,green
    call SetTextColor
    mov dl,temp
    mov dh,26

    mov [esi],dl
    inc bl
 
    call Gotoxy
    mwrite "$"
  
    inc temp
    inc esi
    loop l110

    mov ecx,16
    mov [edi],dh
  ll10:
    mov  [edi],dh
    inc edi
    inc inc1
    loop ll10

;//////////drawing coins for extra score ////

mov esi,offset xextra
mov edi,offset yextra
mov dl,15
mov temp,dl
mov ecx,2
lextra:
    mov eax,green
    call SetTextColor
    mov dl,temp
    mov dh,3

    mov [esi],dl
    
    call Gotoxy
    mwrite "#"
  
    inc temp
    inc esi
    loop lextra

    mov ecx,2
    mov [edi],dh
  llextra:
    mov  [edi],dh
    inc edi
    loop llextra

    mov dl,4
    mov temp,dl
    mov ecx,2
   lextra1:
    mov eax,green
    call SetTextColor
    mov dl,temp
    mov dh,20

    mov [esi],dl
    
    call Gotoxy
    mwrite "#"
  
    inc temp
    inc esi
    loop lextra1

    mov ecx,2
    mov [edi],dh
  llextra1:
    mov  [edi],dh
    inc edi
    loop llextra1


    
    ;           //////////////////
    call DrawPlayer

     
     mov ebp,0

    gameLoop:

    cmp ebp,1
    jne skipping
        mov eax,green
    call SetTextColor
        mov dl,var101
    mov dh,var102
    call Gotoxy
    mov edx, OFFSET var
    call WriteString
    mov ebp,0


    skipping:

   
   mov esi,offset xcoins
        mov edi,offset ycoins
        mov esi,offset xcoins
        mov ecx,lengthof ycoins
     y45:
        mov al,[esi]
        mov ah,[edi]
        cmp xghost,al
        jne noinc1
        

        movex:
        cmp yghost,ah
        jne noinc1

        mov ebp,1

       mov var101,al
       mov var102,ah

       jmp loopexit

        noinc1:
        inc esi
        inc edi

              loop y45

    loopexit:
        


   ;implemeting ghost logics    
     ;1st ghost
        cmp swag,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello
         
        cmp yghost1,21
        je hello
        call UpdateGhost1
        inc yghost1
        call DrawGhost1
        
        jmp swoop


        hello:
        mov swag,1
        call UpdateGhost1
        dec yghost1
        call DrawGhost1 
        cmp yghost1,5
        jne swoop
        mov swag,0
                

;2nd ghost        

        swoop:
        cmp swag1,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello1
         
        cmp xghost,118
        je hello1
        call UpdateGhost
        inc xghost
        call DrawGhost
        
        jmp swoop1


        hello1:
        mov swag1,1
        call UpdateGhost
        dec xghost
        call DrawGhost 
        cmp xghost,2
        jne swoop1
        mov swag1,0

        swoop1:
;3rd ghost

        cmp swag2,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello2
         
        cmp yghost2,21
        je hello2
        call UpdateGhost2
        inc yghost2
        call DrawGhost2
        
        jmp swoop2


        hello2:
        mov swag2,1
        call UpdateGhost2
        dec yghost2
        call DrawGhost2 
        cmp yghost2,5
        jne swoop2
        mov swag2,0


        swoop2:
;4th ghost
        
        cmp swag3,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello3
         
        cmp yghost3,21
        je hello3
        call UpdateGhost3
        inc yghost3
        call DrawGhost3
        
        jmp swoop3


        hello3:
        mov swag3,1
        call UpdateGhost3
        dec yghost3
        call DrawGhost3
        cmp yghost3,5
        jne swoop3
        mov swag3,0

        swoop3:
;ghost5
        cmp swag4,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello4
         
        cmp xghost4,1
        je hello4
        call UpdateGhost4
        dec  xghost4
        call DrawGhost4
        
        jmp swoop4


        hello4:
        mov swag4,1
        call UpdateGhost4
        inc xghost4
        call DrawGhost4
        cmp xghost4,7
        jne swoop4
        mov swag4,0


        swoop4:
;ghost6
        cmp swag5,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello5
         
        cmp xghost5,111
        je hello5
        call UpdateGhost5
        dec  xghost5
        call DrawGhost5
        
        jmp swoop5


        hello5:
        mov swag5,1
        call UpdateGhost5
        inc xghost5
        call DrawGhost5
        cmp xghost5,118
        jne swoop5
        mov swag5,0

        swoop5:

        cmp swag6,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello6
         
        cmp yghost6,23
        je hello6
        call UpdateGhost6
        dec  yghost6
        call DrawGhost6
        
        jmp swoop6


        hello6:
        mov swag6,1
        call UpdateGhost6
        inc yghost6
        call DrawGhost6
        cmp yghost6,27
        jne swoop6
        mov swag6,0

        swoop6:
;ghost 7

        cmp swag7,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello7
         
        cmp yghost7,23
        je hello7
        call UpdateGhost7
        dec  yghost7
        call DrawGhost7
        
        jmp swoop7


        hello7:
        mov swag7,1
        call UpdateGhost7
        inc yghost7
        call DrawGhost7
        cmp yghost7,27
        jne swoop7
        mov swag7,0

        swoop7: 
        
;ghost 8
        cmp swag8,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello8
         
        cmp yghost8,27
        je hello8
        call UpdateGhost8
        inc yghost8
        call DrawGhost8
        
        jmp swoop8


        hello8:
        mov swag8,1
        call UpdateGhost8
        dec yghost8
        call DrawGhost8
        cmp yghost8,23
        jne swoop8
        mov swag8,0


        swoop8:

        cmp swag9,1        ;using bool variable if x approaches left side mov swag is one when x appraoches right side swag is 1
        je hello9
         
        cmp xghost9,118
        je hello9
        call UpdateGhost9
        inc xghost9
        call DrawGhost9
        
        jmp swoop9


        hello9:
        mov swag9,1
        call UpdateGhost9
        dec xghost9
        call DrawGhost9
        cmp xghost9,111
        jne swoop9
        mov swag9,0
        
        swoop9:
;//////////// checking collision of ghost with player  /////////////////////
       
        mov bl,xPos
        cmp bl,xghost1
        je checky1
        cmp bl,xghost
        je checky2
        cmp bl,xghost2
        je checky3
        cmp bl,xghost3
        je checky4
        cmp bl,xghost4
        je checky5
        cmp bl,xghost5
        je checky6
        cmp bl,xghost6
        je checky7
        cmp bl,xghost7
        je checky8
        cmp bl,xghost8
        je checky9
        cmp bl,xghost9
        je checky10

        jne nodec

        checky1:
       
        mov al,yPos
        cmp al,yghost1
        je declife
         jne nodec

        checky2:
         mov al,yPos
        cmp al,yghost
        je declife
         jne nodec

        checky3:
        mov al,yPos
        cmp al,yghost2
        je declife
         jne nodec

        checky4:
        mov al,yPos
        cmp al,yghost3
        je declife
         jne nodec

        checky5:
        mov al,yPos
        cmp al,yghost4
        je declife
        jne nodec


        checky6:
        mov al,yPos
        cmp al,yghost5
        je declife
        jne nodec

        checky7:
        mov al,yPos
        cmp al,yghost6
        je declife
        jne nodec

        checky8:
        mov al,yPos
        cmp al,yghost7
        je declife
        jne nodec

        checky9:
        mov al,yPos
        cmp al,yghost8
        je declife
        jne nodec


        checky10:
        mov al,yPos
        cmp al,yghost9
        je declife
        


        jne nodec
        declife:
        dec life
        mov xPos,44
        mov yPos,14
        cmp life,0
        je exitGame

        call UpdatePlayer
        call DrawPlayer
         nodec:
         ;///////////score/////
        mov esi,offset xcoins
        mov edi,offset ycoins
        mov ecx,lengthof ycoins
     y440:
        mov al,[esi]
        mov ah,[edi]
        cmp xPos,al
        je checkx224
        jmp noinc3

        checkx224:
        cmp yPos,ah
        JE GiveIncrementInScore3
        jne noinc3                         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
       GiveIncrementInScore3:
        inc score
        cmp score,367
        je movetoendmenu
        jne movetolevel3

        movetoendmenu:
        call endgame
        movetolevel3:
        mov al,-7
        mov ah,-18
        mov [esi],al
        mov [edi],ah

        noinc3:
        inc esi
        inc edi

        loop y440
       
        mov esi,offset xextra
        mov edi,offset yextra
        mov ecx,lengthof yextra
     ylife:
        mov al,[esi]
        mov ah,[edi]
        cmp xPos,al
        je checkx222
        jmp noincc

        checkx222:
        cmp yPos,ah
        JE GiveIncrementInScore1
        jne noincc
       GiveIncrementInScore1:
        add life,1
        mov al,-5
        mov ah,-8
        mov [esi],al
        mov [edi],ah
    
        noincc:
        inc esi
        inc edi

              loop ylife

      
        mov eax,white (black * 16)
        call SetTextColor

        ; draw score:
         mov eax,yellow
        call SetTextColor
        mov dl,128
        mov dh,13
        call Gotoxy
        mov edx,OFFSET scoreString1
        call WriteString

         mov dl,128
        mov dh,14
        call Gotoxy
        mov edx,OFFSET scoreString2
        call WriteString
         mov dl,128
        mov dh,15
        call Gotoxy
        mov edx,OFFSET scoreString3
        call WriteString
         mov dl,128
        mov dh,16
        call Gotoxy
        mov edx,OFFSET scoreString4
        call WriteString
         mov dl,128
        mov dh,17
        call Gotoxy
        mov edx,OFFSET scoreString5
        call WriteString
        

        mov dl,128
        mov dh,20
        call gotoxy
        mov ax,score                             
        call Writedec

        mov dl,128
        mov dh,23
        call gotoxy
        mwrite "Name of player : "
        mov edx, OFFSET menuPrompt1
        call WriteString
        call crlf

        mov dl,128
        mov dh,26
        call gotoxy
        mov edx,OFFSET lifestring
        call WriteString
        mov ax,life                             
        call Writedec



        ; gravity logic:
        ;gravity:
        ;cmp yPos,27
        ;jg onGround
        ; make player fall:
        ;call UpdatePlayer
        ;inc yPos
        ;call DrawPlayer
        ;mov eax,80
        ;call Delay
        ;jmp gravity
        onGround:

        mov eax,70
        call delay

        ; get user key input:
        call Readkey
        mov inputChar,al

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame

        cmp inputChar,"w"
        je moveUp

        

        cmp inputChar,"s"
        je moveDown

        cmp inputChar,"a"
        je moveLeft

        cmp inputChar,"d"
        je moveRight

         cmp inputChar ,"p"
        je pauseee

        jmp gameloop


        pauseee:
        call readchar

        jmp gameLoop
        

        moveUp:
        cmp yPos,3
        je gameloop
         mov ecx,lengthof y
        mov esi,offset x
        mov edi,offset y
        y2:
        mov al,[esi]
        mov bl,[edi]
        add bl,1
        cmp yPos,bl

        je checkx
        jne increment
        checkx:
        cmp xPos,al
        je gameloop
        increment:
        inc esi
        inc edi
        loop y2
        ; allow player to jump:
        mov ecx,1
        jumpLoop:
            call UpdatePlayer
            dec yPos
            call DrawPlayer
            mov eax,70
            call Delay
        loop jumpLoop
        jmp gameLoop

        moveDown:
        cmp yPos,27
        je gameloop
        mov ecx,lengthof y
        mov esi,offset x
        mov edi,offset y
        y1:
        mov al,[esi]
        mov bl,[edi]
        sub bl,1
        cmp yPos,bl
        je checkx1
       
        jne increment1
        checkx1:
        cmp xPos,al
        je gameloop
        
        increment1:
        inc esi
        inc edi
        loop y1

        call UpdatePlayer
        inc yPos
        call DrawPlayer
        jmp gameLoop

        moveLeft:
        
        cmp xPos,0
        je goleft
        jne dontgoleft

        goleft:
        cmp yPos,27
        je goleft1
        jne dontgoleft
        goleft1:
        mov dl,0
        mov dh,27
        call gotoxy
        mwrite " ",0
        mov xPos,119
        mov yPos,3
        call UpdatePlayer
        call DrawPlayer
        mov dl,118
        mov dh,3
        call gotoxy
        mov eax,black
        call settextcolor
        mwrite " ",0
        dontgoleft:
    
        mov ecx,lengthof y
        mov esi,offset x
        mov edi,offset y
        y3:
        mov al,[esi]
        mov bl,[edi]
        cmp yPos,bl

        je checkx2
        jne increment3
        checkx2:
        add al,1
        cmp xPos,al
        je gameloop
        increment3:
        inc esi
        inc edi
        loop y3

        call UpdatePlayer
        dec xPos
        call DrawPlayer
        jmp gameLoop

        moveRight:
        cmp xPos,119
        je goright
        jne dontgoright

        goright:
        cmp yPos,3
        je goright1
        jne dontgoright
        goright1:
        mov dl,119
        mov dh,3
        call gotoxy
        mwrite " ",0
        mov xPos,0
        mov yPos,27
        call UpdatePlayer
        call DrawPlayer
        mov dl,0
        mov dh,27
        call gotoxy
        mov eax,black
        call settextcolor
        mwrite " ",0
        dontgoright:


         mov ecx,lengthof y
        mov esi,offset x
        mov edi,offset y
        y4:
        mov al,[esi]
        mov bl,[edi]
        cmp yPos,bl

        je checkx4
        jne increment4
        checkx4:
        sub al,1
        cmp xPos,al
        je gameloop
        increment4:
        inc esi
        inc edi
        loop y4
        call UpdatePlayer
        inc xPos
        call DrawPlayer
        jmp gameLoop



    jmp gameLoop

    exitGame:
    call clrscr
    call endmenu
    exit
ret
level3 endp


;////////////////////////////////////////////








DrawPlayer PROC
    ; draw player at (xPos,yPos):
    mov eax,black(white*16)
    call SetTextColor
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al,"X"
    call WriteChar
    ret
DrawPlayer ENDP


UpdatePlayer PROC
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdatePlayer ENDP




displayPacman PROC
  
    mov eax, 0 
    ;//////////// Displaying Pac Man //////////////



    mov eax,black(brown*16)
    call settextcolor
     
    mov dl,43
    mov dh,5
    call Crlf 
    call Gotoxy
    mov edx, OFFSET pacManString1
    call WriteString
    call delay

    mov dl,43
    mov dh,6
    call Gotoxy
    mov edx, OFFSET pacManString2
    call WriteString
    call delay


    mov dl,43
    mov dh,7
    call Gotoxy
    mov edx, OFFSET pacManString3
    call WriteString
        call delay


    mov dl,43
    mov dh,8
    call Gotoxy
    mov edx, OFFSET pacManString4
    call WriteString
        call delay

    mov dl,43
    mov dh,9
    call Gotoxy
    mov edx, OFFSET pacManString5
    call WriteString
        call delay


    mov dl,43
    mov dh,10
    call Gotoxy
    mov edx, OFFSET pacManString6
    call WriteString
        call delay

    mov dl,43
    mov dh,11
    call Gotoxy
    mov edx, OFFSET pacManString7
    call WriteString
        call delay


    mov dl,43
    mov dh,12
    call Gotoxy
    mov edx, OFFSET pacManString8
    call WriteString
        call delay


    mov eax,blue
    call settextcolor
    ;////////////// FOR Displaying menu ////////////////
   
    
    mov dl,43
    mov dh,17
    call Gotoxy
    mov edx, OFFSET menuPrompt1
    call WriteString

    mov eax, OFFSET menuPrompt1
    mov ecx,255
    call readString


    ;cmp eax,3
    ;je exit1
    ;jne exit2
    ;exit1:
    ;exit
   

    
    ret
displayPacman ENDP

displaymenu proc
    
    
    mov eax,white(black*16)
    call settextcolor
    mov dl,43
    mov dh,7
    call Gotoxy
    mov edx, OFFSET stringmenu1
    call WriteString
    call delay


    mov eax,white(black*16)
    call settextcolor
    mov dl,43
    mov dh,8
    call Gotoxy
    mov edx, OFFSET stringmenu2
    call WriteString
    call delay

     mov eax,white(black*16)
    call settextcolor
    mov dl,43
    mov dh,9
    call Gotoxy
    mov edx, OFFSET stringmenu3
    call WriteString
    call delay

     mov eax,white(black*16)
    call settextcolor
    mov dl,43
    mov dh,10
    call Gotoxy
    mov edx, OFFSET stringmenu4
    call WriteString
    call delay

     mov eax,white(black*16)
    call settextcolor
    mov dl,43
    mov dh,11
    call Gotoxy
    mov edx, OFFSET stringmenu5
    call WriteString
    call delay

     mov eax,white(black*16)
    call settextcolor
    mov dl,43
    mov dh,12
    call Gotoxy
    mov edx, OFFSET stringmenu6
    call WriteString
    call delay

    mov dl,43
    mov dh,13
    call Gotoxy
    mov edx, OFFSET stringmenu7
    call WriteString
    call delay

    mov dl,43
    mov dh,14
    call Gotoxy
    mov edx, OFFSET stringmenu8
    call WriteString
    mov dl,43
    mov dh,17
    call Gotoxy
    call delay

    mov edx, OFFSET menuPrompt3
    call WriteString
    mov dl,43
    mov dh,19
    call Gotoxy
    mov edx, OFFSET menuPrompt4
    call WriteString
    mov dl,43
    mov dh,21
    call Gotoxy
    mov edx, OFFSET menuPrompt5
    call WriteString
     
    mov dl,43
    mov dh,23
    call Gotoxy
    mov edx, OFFSET input
    call WriteString
   mov eax,offset input
   mov eax,255
   call readint

   cmp eax,1
   je level11
   cmp eax,2
   je instructions1
   cmp eax,3
   je exit1
   
   level11:
   call clrscr
   call level1
   instructions1:
   call clrscr
   call Instructions
   
 
    exit1:
    exit
   ret 
displaymenu endp




Instructions Proc
mov eax,green
call settextcolor
mov dl,30
mov dh,1
call Gotoxy
mwrite "///////////////-->>>>>>> INSTRUCTIONS <<<<<<<--\\\\\\\\\\\\",0
call crlf
mov dl,5
mov dh,3
call Gotoxy
mwrite "->Objective : ",0
call crlf
mov dl,5
mov dh,4
call Gotoxy
mwrite "The main goal of Pac-Man is to accumulate points by eating all of the dots in a maze while avoiding ghosts",0
mov dl,5
mov dh,5
call Gotoxy
mwrite "->Controls : ",0
call crlf
mov dl,5
mov dh,6
call Gotoxy

mwrite "Use the arrow keys (W,A,S,D) to control Pac-Man's movement through the maze.",0
call crlf
mov dl,5
mov dh,7
call Gotoxy
mwrite "->->Game Elements : ",0
call crlf
mov dl,5
mov dh,8
call Gotoxy
mwrite "->Pac-Man",0 
call crlf
mov dl,5
mov dh,9
call Gotoxy
mwrite"->Dots",0
call crlf
mov dl,5
mov dh,10
call Gotoxy
mwrite"->Ghosts",0
call crlf
mov dl,5
mov dh,11
call Gotoxy
mwrite "->Scoring:",0
call crlf
mov dl,5
mov dh,12
call Gotoxy
mwrite "Eating dots: 1 point each dot.",0
call crlf
mov dl,5
mov dh,13
call Gotoxy
mwrite"->Extra Lives : ",0
call crlf
mov dl,5
mov dh,14
call Gotoxy
mwrite"Pac-Man starts with three lives.",0 
call crlf
mov dl,5
mov dh,15
call Gotoxy
mwrite"Eating fruits will bring you an extra life",0
call crlf
mov dl,5
mov dh,16
call Gotoxy
mwrite"->Game Over : ",0
call crlf
mov dl,5
mov dh,17
call Gotoxy
mwrite"The game is over when Pac-Man loses all lives.",0
call crlf
mov dl,5
mov dh,18
call Gotoxy
mwrite"You can also press X key to exit, ",0 
call crlf
mov dl,5
mov dh,19
call Gotoxy
mwrite "Press P for the pause menu ",0
call crlf
mov dl,5
mov dh,20
call Gotoxy
mwrite " -------->  # <-------  for extra life",0
call crlf
mov dl,5
mov dh,22
call Gotoxy
mov edx, OFFSET insrtuctionsmsg
mov ecx,lengthof insrtuctionsmsg
call writeString
mov edx, OFFSET insrtuctionsmsg
mov ecx,lengthof insrtuctionsmsg
call readchar

movzx eax,al
cmp al,'c'
je equal1
jne notequal
equal1:
call clrscr
call level1


notequal:
call crlf
mwrite "wrong key pressed",0
exit

ret
Instructions ENDP

DrawGhost proc

   ; draw player at (xPos,yPos):
    mov eax,red (red*16)
    call settextcolor
    mov dl,xghost
    mov dh,yghost
    call Gotoxy
    mov al,"Z"
    call WriteChar
    ret

DrawGhost ENDP


UpdateGhost PROC
    mov eax,black(black*16)
    call settextcolor
    mov dl,xghost
    mov dh,yghost
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdateGhost ENDP

DrawGhost1 proc

   ; draw player at (xPos,yPos):
    mov eax,red (red*16)
    call settextcolor
    mov dl,xghost1
    mov dh,yghost1
    call Gotoxy
    mov al,"Z"
    call WriteChar
    ret

DrawGhost1 ENDP


UpdateGhost1 PROC
mov eax,black (black*16)
    call settextcolor
    mov dl,xghost1
    mov dh,yghost1
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdateGhost1 ENDP

DrawGhost2 proc

   ; draw player at (xPos,yPos):
    mov eax,blue (blue*16)
    call settextcolor
    mov dl,xghost2
    mov dh,yghost2
    call Gotoxy
    mov al,"Z"
    call WriteChar
    ret

DrawGhost2 ENDP



UpdateGhost2 PROC
mov eax,black (black*16)
    call settextcolor
    mov dl,xghost2
    mov dh,yghost2
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdateGhost2 ENDP


UpdateGhost3 PROC
mov eax,black (black*16)
    call settextcolor
    mov dl,xghost3
    mov dh,yghost3
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdateGhost3 ENDP

DrawGhost3 proc

   ; draw player at (xPos,yPos):
    mov eax,green (green*16)
    call settextcolor
    mov dl,xghost3
    mov dh,yghost3
    call Gotoxy
    mov al,"Z"
    call WriteChar
    ret

DrawGhost3 ENDP

UpdateGhost4 PROC
mov eax,black (black*16)
    call settextcolor
    mov dl,xghost4
    mov dh,yghost4
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdateGhost4 ENDP

DrawGhost4 proc

   ; draw player at (xPos,yPos):
    mov eax,red (red*16)
    call settextcolor
    mov dl,xghost4
    mov dh,yghost4
    call Gotoxy
    mov al,"Z"
    call WriteChar
    ret

DrawGhost4 ENDP


UpdateGhost5 PROC
mov eax,black (black*16)
    call settextcolor
    mov dl,xghost5
    mov dh,yghost5
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdateGhost5 ENDP

DrawGhost5 proc

   ; draw player at (xPos,yPos):
    mov eax,blue (blue*16)
    call settextcolor
    mov dl,xghost5
    mov dh,yghost5
    call Gotoxy
    mov al,"Z"
    call WriteChar
    ret

DrawGhost5 ENDP

UpdateGhost6 PROC
mov eax,black (black*16)
    call settextcolor
    mov dl,xghost6
    mov dh,yghost6
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdateGhost6 ENDP


DrawGhost6 proc

   ; draw player at (xPos,yPos):
    mov eax,red (red*16)
    call settextcolor
    mov dl,xghost6
    mov dh,yghost6
    call Gotoxy
    mov al,"Z"
    call WriteChar
    ret

DrawGhost6 ENDP



UpdateGhost7 PROC
mov eax,black (black*16)
    call settextcolor
    mov dl,xghost7
    mov dh,yghost7
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdateGhost7 ENDP

DrawGhost7 proc

   ; draw player at (xPos,yPos):
    mov eax,green (green*16)
    call settextcolor
    mov dl,xghost7
    mov dh,yghost7
    call Gotoxy
    mov al,"Z"
    call WriteChar
    ret

DrawGhost7 ENDP

UpdateGhost8 PROC
mov eax,black (black*16)
    call settextcolor
    mov dl,xghost8
    mov dh,yghost8
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdateGhost8 ENDP

DrawGhost8 proc

   ; draw player at (xPos,yPos):
    mov eax,green (green*16)
    call settextcolor
    mov dl,xghost8
    mov dh,yghost8
    call Gotoxy
    mov al,"Z"
    call WriteChar
    ret

DrawGhost8 ENDP

UpdateGhost9 PROC
mov eax,black (black*16)
    call settextcolor
    mov dl,xghost9
    mov dh,yghost9
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdateGhost9 ENDP

DrawGhost9 proc

   ; draw player at (xPos,yPos):
    mov eax,blue (blue*16)
    call settextcolor
    mov dl,xghost9
    mov dh,yghost9
    call Gotoxy
    mov al,"Z"
    call WriteChar
    ret

DrawGhost9 ENDP



endmenu proc
        call clrscr
        mov eax,black(white * 16)
        call SetTextColor

        mov dl,40
        mov dh,12
        call gotoxy
        mwrite "BETTER LUCK NEXT TIME!!! :>("
        mov dl,40
        mov dh,15
        call gotoxy
         
        mov edx,offset endstring
        call writestring

        mov ax,score                              ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        call Writedec
        call crlf
        mov dl,40
        mov dh,17
        call gotoxy
        mwrite "Name of player : "
        mov edx, OFFSET menuPrompt1
        call WriteString
        call crlf
        call waitmsg
endmenu endp

endgame proc
        call clrscr
        mov eax,black(white * 16)
        call SetTextColor

        mov dl,40
        mov dh,12
        call gotoxy
        mwrite "You Won :>)"
        mov dl,40
        mov dh,15
        call gotoxy
         
        mov edx,offset endstring
        call writestring

        mov ax,score                              ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        call Writedec
        call crlf
        mov dl,40
        mov dh,17
        call gotoxy
        mwrite "Name of player : "
        mov edx, OFFSET menuPrompt1
        call WriteString
        call crlf
        call waitmsg
endgame endp



END main
