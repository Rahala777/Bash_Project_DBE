#!/bin/bash
export LC_COLLATE=C
shopt -s extglob

export PATH=$PATH:$PWD
chmod u+x *.sh
chmod u+x check*
chmod u+x function_menu
if ! [ -d DB ]
then 
    mkdir DB
fi
. DB_main_menu.sh
