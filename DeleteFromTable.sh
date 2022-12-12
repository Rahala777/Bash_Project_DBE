# !/bin/bash
 export LC_COLLATE=C
 shopt -s extglob
read -p "please enter table name: " tablename
tableExist=`. check_table_exist . $tablename`
while [ "$tableExist" = false ]
do
    echo "table doesn't exist!!!!!!!!!!!!!!!!!!!!"
    select choice in "list table menu" "back to table of menu"
    do 
    case $choice in 
    "list table menu")
        . ListTables.sh
        . table_main_menu.sh
    ;;
    "back to table of menu")
        
    ;;
    *)
        echo "please enter number between 1 ----2 "
        . table_main_menu.sh
    ;;
    esac
    done
    
done
select choice in "Delete all" "Delete row by column value"
do
case $choice in
"Delete all")
    echo "" > "$tablename"
    echo "Table data deleted succssfully"
    . table_main_menu.sh
;;
"Delete row by column value")
    column_names=( $(
        awk '
        BEGIN{FS=" ";}
        {
            print $1
        }END{}' ./"$tablename"_meta_data) ) 
    . function_menu "${column_names[@]}" #creating menue with table columns 
    read -p "enter "$colname" value to delete its row: " colval
    doescolvalExist=`. check_columnvalue_exist "$tablename" "$colnum" "$colval"`
    
    while [ "$doescolvalExist" = false ]
    do
        echo "column value doesn't exist!!!!!!!!!!!!!!!!!!"
        read -p "enter "$colname" value to delete its row: " colval
        doescolvalExist=`. check_columnvalue_exist "$tablename" "$colnum" "$colval"`
    done
    line=$(
    awk -v column_num="$colnum" -v columval="$colval" '
        BEGIN{FS=" ";line=""} 
        {
            if ($column_num==columval)
                line=NR
        }
        END{print line}
    ' $tablename
    )
    sed -in "$line"d "$tablename"
    echo "Row deleted succssfully"
    . table_main_menu.sh
;;
*)
    echo "invaild value!!!!!!!!!!"

;;      
esac
done