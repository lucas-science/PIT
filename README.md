# PIT - JEUX ligne de commande en bash
Dans ce mini jeux on va pouvoir incarner un personnage qui s'est fait piraté.
Le Hacker lui a laissé des indices pour pouvoir retrouver ses données décryptés. 

### Comment jouer ?
* pour commencer, faites la commande : ```sudo ./start.sh```
* un fichier `message_du_h@cker` va apparaître, on retrouvera dans ce dernier, à la fin, un message avec l'indice qui y est donné
* Le fichier `AIDE` permet d'avoir des explications essentiels pour résoudre l'énigme.


### Solution
* on trouve le PID du virus : `ps aux` => on identifie la ligne correspondant à './.virus.sh'
* on cherche < Val PID > dans le message_du_h@cker : `grep -n '<Val PID>' message_du_h@cker` => on obtient : < Val PID >:PIZZA. Ainsi PIZZA sera le nom du fichier à retrouver
* on cherche le fichier pizza : ``find -name 'PIZZA'`
* on cherche le groupe qui à accès au script de fin : `ls -l`=> on remarque que c'est 'groupeDesH@ckers'
* on fini le jeux en éxecutant : `./decrypte.sh groupeDesH@ckers`
