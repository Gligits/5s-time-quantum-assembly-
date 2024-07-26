data segment
    msg db "deroutement fait....",10,10,13,"$"
    msg_tache1 db "tache1 en cours d'execution.....",10,13,"$"
    msg_tache2 db "tache2 en cours d'execution.....",10,13,"$"
    msg_tache3 db "tache3 en cours d'execution.....",10,13,"$"
    msg_tache4 db "tache4 en cours d'execution.....",10,10,13,"$" ;on ajoute 10 10 13 pour faire un espace et saut la ligne comme dans l'exemple donner;
    compt db 91
    ancien_cs dw ?
    ancien_ip dw ?
data ends
 
maPile SEGMENT STACK
dw 256 dup(?)
tos label word
maPile ENDS

code SEGMENT 
assume CS:code, DS: data

; ---------------------------------------------- ;    
; cette proc fait le deroutement de 1Ch          ;
; ---------------------------------------------- ;  
derout_1CH PROC NEAR
 push ds 
derout: mov ax , seg new 
 mov ds , ax
 mov dx , offset new 
 mov ax , 251CH 
 int 21H 
 mov cx, 3 
 pop ds 
 ret 
derout_1CH ENDP
; ---------------------------------------------- ;    
; cette proc fait l'affichage de msg        ;
; ---------------------------------------------- ;  
affichemsg PROC NEAR 

 mov dx , offset msg
 mov ah , 09h 
 int 21h 
 ret 
affichemsg endp

; ---------------------------------------------- ;    
; cette proc nous peremet de choisir le bon message et l'affiche (en utilisant 21h);
; cela en faisant des cmp  avec cx (qui est set a 3 dans la proc deroute_1CH et qui represente le nbr de taches ( a partir de zero ) et choissir a chaque fois la tache qui convien ;
; dans la tache 4 on doit remtre cx a 4 (3+1 car il va etre dec au retour a la proc repetition;
; ---------------------------------------------- ; 
afficheX PROC NEAR 
 
    cmp cx ,3
    jz un
    cmp cx ,2
    jz deux
    cmp cx, 1
    jz trois 
    cmp cx,0
    jz quatre 
un:mov dx , offset msg_tache1
     jmp FINX 
deux:mov dx , offset msg_tache2
     jmp FINX 
trois:mov dx , offset msg_tache3
     jmp FINX 
     quatre:mov dx , offset msg_tache4
    mov cx,4 

FINX:mov ah , 09h 
     int 21h 
     ret 
 afficheX endp
 
 ; ---------------------------------------------- ;    
 ; cette proc est utilisee pour eviter la repetition  du code dans 1CH ;
; ---------------------------------------------- ;
repetition PROC NEAR
 call NEAR PTR afficheX
    dec cx
    ret
repetition ENDP 
; ---------------------------------------------- ;    
; code routine 1CH         
; le compteur est set a 91 dans le data seg (91=18.2*5 = 5sec) ; 
; le compteur est dec a chaque fois que le timer appelle l'int 1CH ; 
; si le compteur est different de 0 on sort de l'int ; 
     ; sinon on continue ;                       ;
; ---------------------------------------------- ;
new: mov ax, seg compt 
     mov ds , ax 
     dec compt 
     jnz fin      
     
call NEAR PTR repetition   

 mov compt , 91 

fin: iret 
; ---------------------------------------------- ;    
; Programme principal ;                        ;
; on sauvgarde l'int 1CH  ; 
; on affiche le 1er msg ( deroutement fait ) hors boucle  ;
; et on deroute l'int 1CH ;
     ; puis on utilise la boucle jmp boucle pour faire marcher le programme infiniment ;
 ; ---------------------------------------------- ; 
start: mov ax , data
       mov ds , ax
       
       call NEAR PTR affichemsg
       call NEAR PTR derout_1CH 
       boucle :jmp boucle       

code ENDS 
 END start
