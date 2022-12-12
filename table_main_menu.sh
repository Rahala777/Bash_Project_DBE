#!/bin/bash
export LC_COLLATE=C
shopt -s extglob

select choice in "create_table" "list_tables" "drop_table" "insert_into_table" "select_from _table" "delete_from_table" "back_to_menu"
do 
case $choice in 
"create_table")
#creat table by calling file .sh 
    . CreateTable.sh
;;
"list_tables")
#list tables by calling file .sh 
    . ListTables.sh
;;
"drop_table")
#drop table by calling file .sh
    . DropTaple.sh
;;
"insert_into_table")
#insert into table by calling file .sh
    . InsertIntoTable.sh
;;
"select_from _table")
#select value from table by calling file .sh 
    SelectFromTable.sh
;;
"delete_from_table")
#delete from table (delete line , delete all table) by calling file .sh
    . DeleteFromTable.sh
;;
"back_to_menu")
#back to main menu of table from table by calling file .sh 
    cd ../..
    . DB_main_menu.sh
;;
*)
    echo "Enter number between (1 ------- 7)"
    . table_main_menu.sh
;;   
esac
done



