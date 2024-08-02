# 5s-time-quantum-assembly-
Definition of interruption 1CH: Clock tick
This interruption is called by the BIOS at each tick of the computer's internal clock, which occurs approximately 18.2064819336 times per second.

## _TACHE1_ : 
This is a MODULAR program that, using interruption 1CH, suspends the currently running main program and executes a procedure every second that will display the following message: '1 sec écoulée......'. The main program repeatedly displays the message 'Début du quantum de temps logiciel' on the screen. The delay between two consecutive messages is set by two nested loops inserted in the main program. This program will continue to run without stopping, and the message '1 sec écoulée....' will be displayed every second.


                                                         output : 

    **** Début du quantum de temps logiciel **** 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1
    sec écoulée...... 1 sec écoulée..... 1 sec écoulée... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1
    sec écoulée...... 1 sec écoulée...... 1 sec écoulée.... 1 sec écoulée....... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée......
    **** Début du quantum de temps logiciel **** 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1
    sec écoulée...... 1 sec écoulée..... 1 sec écoulée... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée...... 1
    sec écoulée...... 1 sec écoulée...... 1 sec écoulée.... 1 sec écoulée....... 1 sec écoulée...... 1 sec écoulée...... 1 sec écoulée......

## _TACHE2_ : 
This is a MODULAR program that, using periodic interruption 1CH, interrupts the currently running main program and launches one of four tasks every five seconds in the following order: task1, task2, task3, task4.  
Each task is only responsible for displaying its own message :
Task 1 message : ‘Tache 1 est en cours d’exécution....’
Task 2 message : ‘Tache 2 est en cours d’exécution....’
Task 3 message : ‘Tache 3 est en cours d’exécution....’
Task 4 message : ‘Tache 4 est en cours d’exécution....’

This program will continue to run without stopping and will execute a task every 5 seconds.


                                                         output : 
    tache1 en cours d"execution....
    tache2 en cours d"execution....
    tache3 en cours d"execution....
    tache4 en cours d"execution....
    tache1 en cours d"execution....
    tache2 en cours d"execution....
    tache3 en cours d"execution....
    tache4 en cours d"execution....

PS: TACHE1_5 et TACHE2_5 are modifications of the two programs so that each of them stops after 5 minutes of execution.
