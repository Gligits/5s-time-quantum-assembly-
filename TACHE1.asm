data SEGMENT 
 msg1 db "deroutement fait....",10,"$"
 msg2 db 10,"**** Debut du quantum de temps logiciel **** ","$" 
 msg3 db "1 sec ",130,"coul",130,"e...... ","$"
 msg4 db "1 sec ",130,"coul",130,"e......","$"; on affiche c emessage quand on est situ?s juste apres le msg 2;
                                               ; il est different du message 3 car il ne contient pas d'espace a la fin ;
                                ; on a enlev? l'espace pour qu il ne cause pas de probleme car on va appeller la proc saut juste apres (dans 1CH);
 msg_saut db 10 , 13 ,"$" 
 compt db 19
  
 
data ENDS 

code SEGMENT 
assume CS:code, DS: data
; ---------------------------------------------- ;    
; cette proc fait le deroutement de 1Ch          ;
; ---------------------------------------------- ;  
derout_1CH PROC NEAR 
derout: mov ax , seg new 
 mov ds , ax
 mov dx , offset new 
 mov ax , 251CH 
 int 21H 
 mov cx , 1 
 ret 
derout_1CH ENDP

; ---------------------------------------------- ;    
; cette proc fait l'affichage du 1er msg        ;
; ---------------------------------------------- ;  
affiche1 PROC NEAR 
 mov ax, data 
 mov ds , ax
 mov dx , offset msg1
 mov ah , 09h 
 int 21h 
 ret 
 affiche1 endp
 
; ---------------------------------------------- ;    
; cette proc fait l'affichage du 2eme msg        ;
; ---------------------------------------------- ;  
affiche2 PROC NEAR 
 mov ax, data 
 mov ds , ax
 mov dx , offset msg2 
 mov ah , 09h 
 int 21h 
 ret 
 affiche2 endp
 ; ---------------------------------------------- ;    
 ; cette proc fait l'affichage de l espace        ;
; ---------------------------------------------- ;  
 affiche4 PROC NEAR 
 mov ax, data 
 mov ds , ax 
 mov dx , offset msg4
 mov ah , 09h 
 int 21h 
 ret 
 affiche4 endp
 
; ---------------------------------------------- ;    
; cette proc fait l'affichage du 3eme msg        ;
; ---------------------------------------------- ;  
affiche3 PROC NEAR 
 mov ax, data 
 mov ds , ax 
 mov dx , offset msg3 
 mov ah , 09h 
 int 21h 
 ret 
 affiche3 endp
 
; ---------------------------------------------- ;    
; cette proc fait le saut a la ligne             ;
; ---------------------------------------------- ;  
saut PROC NEAR 
 mov ax,  data 
 mov ds , ax 
 mov dx , offset msg_saut 
 mov ah , 09h 
 int 21h 
 ret 
 saut endp
 
; ---------------------------------------------- ;    
 ; nouveau code de la routine 1CH : ; 
; le compteur est set a 18 dans le data seg ; 
; le compteur est dec a chaque fois que le timer appelle l'int 1CH ; 
; si le compteur est different de 0 on sort de l'int ; 
     ; sinon on continue :; 
; on compare cx avec 1 pour savoir si on est situ?s juste pres le message 2 ( debut de qtm) ; 
; dans le cas ou on est apres le debut de qtm il va falloir afficher 1 sec ecoul?e (du message 4) et faire un saut de ligne si  ; 
     ; sinon dans le cas ou on n'est pas apres le message 2: ; 
         ; on affiche le messag 1 sec ecoulee( du message 3) ; 
; puis on verifie si le cx est egal a zero ; 
     ; dans le cas ou il l'est cela voudrait dire qu on est arriv?s a la fin de la ligne ( la ligne peut comporter au max 4 msgs (1 sec ecoulee......);
        ; on va donc faire un aut de ligne et r?initialiser cx a 4 ; 
     ; sinon ( cas cx <> 0 on cela voudrait dire qu'il y a encore de l espace dans la ligne on  va donc dec cx et on ne fera donc pas de saut de ligne ;             ;
; ---------------------------------------------- ;   
new: mov ax, seg compt 
     mov ds , ax 
     dec compt 
     jnz fin 
     cmp cx ,1
     jnz Ms_3
     call NEAR PTR affiche4
     jmp suite1
Ms_3: call NEAR PTR affiche3   
suite1: loop suite2
     call NEAR PTR saut
     mov cx , 4   
suite2: mov compt , 18 
fin: iret 

; ---------------------------------------------- ;    
; Programme principal                            ;
; on sauvgarde l'int 1CH  ; 
; on affiche le 1er msg ( deroutement fait ) hors boucle  ;
; contenu de la boucle : ; 
     ; affichage du msg de debut de qtm ; 
     ; appel qu deroutement de 1cH ;
     ; decrementation  de SI 454 fois ce qui est proche 20*18 ( le nombre de retour a notre boucle avant l'affichage du debut de qtm);
    ; quand SI sera egal a zero on aura afficher 20 fois me message (1 sec ecoulee......) ; 
    ; on fera alors un jmp au debut de la boucle pour refaire ces etapes ; 
    
; ---------------------------------------------- ;  

start: 
         call NEAR PTR affiche1
externe: call NEAR PTR affiche2
        
         call NEAR PTR derout_1CH 
         mov si,454
         mov bp, 0
interne:dec bp
        jnz interne
        dec si
        jnz interne
        jmp externe 
           
code ENDS 
 END start
