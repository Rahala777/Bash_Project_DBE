#!/bin/bash
export LC_COLLATE=C
shopt -s extglob


read -p "Enter Database Name: " Databasename
name_DB=`. check_DB_exist ./DB $Databasename`
if [ "$name_DB" = true ]
then
    rm -r ./DB/$Databasename
    echo "$Databasename deleted successfully!!!!!!!!!!!  😀"
    . DB_main_menu.sh
else  
    echo "Database doesn't exist!!!!!!!!!!!!!"
    select choice in "renter database" "back to database menu"
    do 
    case $choice in
    "renter database")
        read -p "please Enter Database Name: " Databasename
        name_DB=`. check_DB_exist ./DB $Databasename`
        if [ "$name_DB" = true ]
        then
            rm -r ./DB/$Databasename
            echo "$Databasename deleted successfully!!!!!!!!!!!  😀"
            . DB_main_menu.sh
        else
            echo "Database doesn't exist!!!!!!!!!!!!!"
            echo "press enter to re-choose"
        fi
    ;; 

    "back to database menu")
        . DB_main_menu.sh
    ;;
    esac
    done
        
fi