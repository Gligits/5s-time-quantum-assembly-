# 5s-time-quantum-assembly-

## Deffinition de l'interruption  1CH : Tic d'horloge
Cette interruption est appelé par le BIOS à chaque tic de l'horloge interne de l'ordinateur, soit à tous les 18,2064819336 fois par secondes.

## _TACHE1_ : 
Est un programme MODULAIRE qui permet à l’aide de l’interruption 1CH, de provoquer la suspension du programme principal en cours d’exécution et l’exécution
toutes les secondes d’une procédure qui affichera le message suivant ‘1 sec écoulée ......’.
Le programme principal affiche sur l’écran le message répété ‘Début du quantum de temps logiciel’. 
Le délai entre deux messages consécutifs est fixé par par 2 boucles imbriquées insérées dans le programme principal.
Ce programme continuera de tourner sans s’arrêter, et le message ‘1 sec écoulée....’ sera affiché chaque seconde.

                                                         Affichage du programme complilé : 

    **** Début du quantum de temps logiciel **** 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1
    sec écoulée...... 1 sec écoulée..... 1 sec écoulée... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1
    sec écoulée...... 1 sec écoulée...... 1 sec écoulée.... 1 sec écoulée....... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée......
    **** Début du quantum de temps logiciel **** 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1
    sec écoulée...... 1 sec écoulée..... 1 sec écoulée... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1
    sec écoulée...... 1 sec écoulée...... 1 sec écoulée.... 1 sec écoulée....... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée......

## _TACHE2_ : 
Est un programme MODULAIRE qui permet à l’aide de l’interruption périodique 1CH d’interrompre le programme principal en cours d’exécution , de lancer toutes les cinq secondes
une tache parmi 4 taches dans l’ordre suivant : tache1, tache2, tache3 , tache4.
Chaque tache se charge seulement d’afficher son propre message :
Message de la tache 1 : ‘Tache 1 est en cours d’exécution....’
Message de la tache 2 : ‘Tache 2 est en cours d’exécution....’
Message de la tache 3 : ‘Tache 3 est en cours d’exécution....’
Message de la tache 4 : ‘Tache 4 est en cours d’exécution....’

Ce programme continuera de tourner sans s’arrêter et exécutera une tache chaque 5 secondes.

                                                          Affichage du programme complilé : 
    tache1 en cours d"execution....
    tache2 en cours d"execution....
    tache3 en cours d"execution....
    tache4 en cours d"execution....
    tache1 en cours d"execution....
    tache2 en cours d"execution....
    tache3 en cours d"execution....
    tache4 en cours d"execution....



