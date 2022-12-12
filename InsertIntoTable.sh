#!/bin/bash
export LC_COLLATE=C
shopt -s extglob

read -p "enter table name: " TN
tableExist=`. check_table_exist . $TN`

while [ "$tableExist" = false ]
do
    echo "table doesn't exist"
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
numberofcolumn=`cat "$TN"_meta_data | wc -l`
column_names=( $(
awk '
    BEGIN{FS=" ";}
    {
        print $1
    }END{}' ./"$TN"_meta_data) )


column_data_types=( $(
awk '
    BEGIN{FS=" ";}
    {
        print $2
    }END{}' ./"$TN"_meta_data) )


entered_values=()
num=0
while [ "$num" -lt "$numberofcolumn" ]
do
    read -p "Enter ${column_names[$num]}: " enteredvalue
    
    if [[ "$num" = 0 ]]; then
    # check id becuase first column is unique
        doesidexist=`. check_id_exist ./"$TN" $enteredvalue`
        isidempty=`. check_id_empty "$enteredvalue"`
        
        while [[ "$doesidexist" = true || "$isidempty" = true ]]
        do
            
            if [ "$doesidexist" = true ]; then
                echo "this "${column_names[$num]}" is already exist"
                read -p "Enter ${column_names[$num]}: " enteredvalue
                doesidexist=`. check_id_exist ./"$TN" $enteredvalue`
                isidempty=`. check_id_empty "$enteredvalue"`
            fi
            if [ "$isidempty" = true ]; then
                echo "this is a Pk can't be empty"
                read -p "Enter ${column_names[$num]}: " enteredvalue
                doesidexist=`. check_id_exist ./"$TN" $enteredvalue`
                isidempty=`. check_id_empty "$enteredvalue"`
            fi
        done
    fi
    # check current column data type
    if [ "${column_data_types[$num]}" = "integer" ]; then
        # ! revers regix
        while ! [[ $enteredvalue =~ ^[+-]?[0-9]+$ ]]
        do
            echo "Please enter an integer: "
            read -p "Enter ${column_names[$num]}: " enteredvalue
        done
    fi
    entered_values+=($enteredvalue)
    let num=$num+1
done
# inserting all data of of list in table
echo "${entered_values[@]}" >> "$TN"
echo "data inserted successfully!!!!!!!!!!!!!!!!!!!"
echo "😀"
