data segment
    msg db "deroutement fait....",10,10,13,"$"
    msg_tache1 db "tache1 en cours d'execution.....",10,13,"$"
    msg_tache2 db "tache2 en cours d'execution.....",10,13,"$"
    msg_tache3 db "tache3 en cours d'execution.....",10,13,"$"
    msg_tache4 db "tache4 en cours d'execution.....",10,10,13,"$"
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
; save                                           ;
; ---------------------------------------------- ;  
save_1CH PROC NEAR
mov ax, 351CH
int 21H
mov ancien_cs, es
mov ancien_ip, bx
ret 
save_1CH ENDP

; ---------------------------------------------- ;    
; restaure                                       ;
; ---------------------------------------------- ;  

restaurer_1CH PROC NEAR
push ds
mov ds , ancien_cs
mov dx , ancien_ip
mov ax , 251CH
int 21H
pop ds 
ret
restaurer_1CH ENDP 
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
; cette fonction evite la repetition  du code dans 1Ch ;
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
     ; sinon on continue on affiche les messages et on dec a chque fois SI  ;                       
;-------------------------- -------------------------;
new: mov ax, seg compt 
     mov ds , ax 
     dec compt 
     jnz fin      
     
call NEAR PTR repetition   

 mov compt , 91 
     dec si 
     jz fin2
fin: iret 

; ---------------------------------------------- ;    
; programme principal     

; pour les 5 minutes on met dans si la valeur 60 (60= le nbr de fois qu'on va afficher les 4 taches pendant 5min);
; ainsi apres chauque affichache de msg l'int 1C H va faire une dec de SI  ; 
 ; dans le cas ou il est egal a zero cela voudrait dire que 5 min sont ecoulees on fera un saut au restauration du code de base de 1CH et on utilisera 21h pour arreter notre programme ;
 ; ---------------------------------------------- ;                        
start: mov ax , data
       mov ds , ax
       mov ax , mapile
       mov ss , ax
       lea sp, tos
       mov si,60
      
call NEAR PTR save_1CH
       
       call NEAR PTR affichemsg
       call NEAR PTR derout_1CH 
       boucle :jmp boucle       
 
           
        
fin2: call NEAR PTR restaurer_1CH 
      mov ax,4c00h
      int 21h       

code ENDS 
 END start
