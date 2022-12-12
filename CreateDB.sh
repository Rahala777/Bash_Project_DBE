#!/bin/bash
export LC_COLLATE=C
shopt -s extglob
read -p "please enter New Database Name: " databasename

NameValid=`. check_value_valid $databasename`
DatabaseExist=`. check_DB_exist ./DB $databasename`
while [[ $DatabaseExist = true || "$NameValid" = false ]]
do
    if [ $DatabaseExist = true ]; then
        echo "Database Alredy Exist !!!!!!!!!!!!!!!"
        read -p "Enter New Database Name: " databasename
        NameValid=`. check_value_valid $databasename`
        DatabaseExist=`. check_DB_exist ./DB $databasename`
    fi
    if [ "$NameValid" = false ]; then
         echo "Invalid Database Name"
        read -p "Enter New Database Name: " databasename
        NameValid=`. check_value_valid $databasename`
        DatabaseExist=`. check_DB_exist ./DB $databasename`
    fi
done

mkdir ./"DB/$databasename" 
echo "Database Created scussefully !!!!!!!!!!"
. DB_main_menu.sh


