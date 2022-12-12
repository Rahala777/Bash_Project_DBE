#!/bin/bash
export LC_COLLATE=C
shopt -s extglob

read -p "please enter table name: " TN
tableExist=`. check_table_exist . $TN`
echo "$tableExist"
while [ "$tableExist" = false ]
do
    echo "table doesn't exist!!!!!!!!!!!!!"
    select choice in "list table menu" "back to table of menu"
    do 
    case $choice in 
    "list table menu")
        . ListTables.sh
        . table_main_menu.sh
    ;;
    "back to table of menu")
        . table_main_menu.sh
    ;;
    *)
       echo "please enter number between 1 ----2 "
        
    ;;
    esac
    done
done

select choice in "select column" "select all" "select row"
do
case $choice in
"select column")
    column_names=( $(
        awk '
        BEGIN{FS=" ";}
        {
            print $1
        }END{}' ./"$TN"_meta_data) ) 
#creating menue with table columns         
    . function_menu "${column_names[@]}" 
    cat $TN | cut -d" " -f$colnum

    . table_main_menu.sh
;;
"select all")
    if [[ `cat $TN` != "" ]]
    then 
        cat $TN

        . table_main_menu.sh
        
    else 
        echo "table is empty !!!!!!"
        . table_main_menu.sh
    fi
;;
"select row" )
    column_names=( $(
        awk '
        BEGIN{FS=" ";}
        {
            print $1
        }END{}' ./"$TN"_meta_data) )
    . function_menu "${column_names[@]}" 
    columnname="$colname"
    columnnumber="$colnum"
    read -p "enter "$columnname" equal to : " columnvalue
    echo "$TN" "$columnnumber" "$columnvalue"
    doescolvalExist=`. check_columnvalue_exist "$TN" "$columnnumber" "$columnvalue"`
    while [ "$doescolvalExist" = false ]
    do
        echo "column value doesn't exist !!!!!!!!!!!!!1"
        read -p "please enter "$columnname" value to select: " columnvalue
        doescolvalExist=`. check_columnvalue_exist "$TN" "$columnnumber" "$columnvalue"`
    done
    awk -v column_num="$colnum" -v columval="$columnvalue" '
        BEGIN{FS=" ";}
        {
            if ($column_num==columval)
                print $0
        }END{}' ./"$TN"
    . table_main_menu.sh
;;
*)
    echo "invaild value !!!!!!!!!!! "
;;    
esac
done

