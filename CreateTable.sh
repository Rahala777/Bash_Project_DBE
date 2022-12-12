# !/bin/bash
 export LC_COLLATE=C
 shopt -s extglob

read -p "please enter new table name " TN
tableExist=`. check_table_exist . $TN`
tableNameValid=`. check_value_valid $TN`
while [[ "$tableExist" = true || "$tableNameValid" = false ]]
do
    if [ "$tableExist" = true ]; then
        echo "Table already exists"
        read -p "Enter new table name " TN
        tableExist=`. check_table_existt . $TN`
        tableNameValid=`. check_value_valid $TN`
    fi 
    if [ "$tableNameValid" = false ]; then
        echo "Invalid table name"
        read -p "Enter new table name " TN
        tableExist=`. check_table_exist . $TN`
        tableNameValid=`. check_value_valid $TN`
    fi 
done

touch $TN "$TN"_meta_data

read -p "please enter number of columns " columnnumber
while [[ "$columnnumber" -le 0 ]]
do
    echo "Invalid number of columns"
    read -p "Enter number of columns " columnnumber
done

echo "First column will be Primarykey (must be unique). "
for (( i=1; i<="$columnnumber"; i++ ))
do
    
    read -p "please enter column name " columnName
    columnExist=`. check_columnvalue_exist ./"$TN"_meta_data $columnName`
    colNameValid=`. check_value_valid $columnName`
    while [[ "$colNameValid" = false || "$columnExist" = true ]]
    do
        if [ "$colNameValid" = false ]; then
            echo "Invalid column name"
            read -p "Enter column number $i name " columnName
            colNameValid=`. check_value_valid $columnName`
            columnExist=`. check_columnvalue_exist ./"$TN"_meta_data $columnName`
        fi
        if [ "$columnExist" = true ]; then
            echo "column already exist"
            read -p "Enter column number $i name " columnName
            colNameValid=`. check_value_valid $columnName`
            columnExist=`. check_columnvalue_exist ./"$TN"_meta_data $columnName`
        fi
    done

    
    read -p "Enter Column number $i data type (integer or string) " columndatatype
    while [[ "$columndatatype" != "integer" && "$columndatatype" != "string" ]]
    do
        echo "Invalid cloumn data type"
        read -p "Enter Column number $i data type (integer or string) " columndatatype
    done

    echo "$columnName $columndatatype" >> "$TN"_meta_data


done
echo "table created successfully !!!!!!!!!!!!!"
. table_main_menu.sh






