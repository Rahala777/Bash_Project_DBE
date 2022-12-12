#!/bin/bash
export LC_COLLATE=C
shopt -s extglob

read -p "Enter Database Name: " databasename
ret=`. check_DB_exist ./DB $databasename`
if [ "$ret" = true ]
then
    echo "connected successfully!!!!!!!!!!!!"
    cd ./DB/$databasename
    . table_main_menu.sh
else
    echo "Database doesn't exist !!!!!!!!!!!"
    . DB_main_menu.sh
fi