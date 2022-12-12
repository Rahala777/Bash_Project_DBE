#!/bin/bash
export LC_COLLATE=C
shopt -s extglob

select choice in "Create Database" "Connect to Database" "List Database" "Drop Database"  "Exit"
do 
case $choice in 
"Create Database")
#creat database by calling file .sh 
    . CreateDB.sh 
;;
"Connect to Database")
#list database by calling file .sh 
    . ConnectToDB.sh
;;
"Drop Database")
#drop database by calling file .sh 
    . DropDB.sh
;;
"List Database")
#connect database by calling file .sh 
    . ListDB.sh
;;
"Exit")
#exit the program
    exit
;;
*)
    echo "Entered  valid number (1 ------- 5)"
;;    
esac
done