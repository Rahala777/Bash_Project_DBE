#!/bin/bash
export LC_COLLATE=C
shopt -s extglob
read -p "enter table name: " TN 
find_table=`ls -F | grep -v / | grep -v _meta_data`
table_exist=`. check_table_exist . $TN` 
if [[ "$find_table" == "" ]]
then
    echo "Nothing to Delete!!!!!!!!!!!!!!"
    . table_main_menu.sh
elif [ "$table_exist" = true ]
then
    rm $TN "$TN"_meta_data
    echo "table is removed successfully!!!!!!!!!!!!!!!"
    . table_main_menu.sh
else 
    echo "table doesn't exist!!!!!!!!!!!!"
    . table_main_menu.sh
fi