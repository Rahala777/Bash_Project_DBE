#!/bin/bash
export LC_COLLATE=C
shopt -s extglob

res=`ls -F | grep -v / | grep -v _meta_data`
if [[ "$res" == "" ]]
then
    echo "Nothing to list"
    . table_main_menu.sh
else
    echo "$res"
    . table_main_menu.sh
fi 

