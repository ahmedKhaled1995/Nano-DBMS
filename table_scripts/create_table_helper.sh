#! /bin/bash

# This script is used to get columns names and types for a given table and create that table

table_name=$1

types="int"
names="id"

function create_table
{
    # Getting number of columns
    number_coulmns_entered=0
    while [ $number_coulmns_entered == 0 ]
    do
        echo "Enter number of columns: "
        . utils/get_number.sh
        if [ $? == 1 ]
        then
            echo "Invalid"
            continue
        fi
        
        # Getting th clean input
        columns_num=$entered_number # entered_number is defined in the above script
        
        # Checking if user entered valid number
        if [ $error == 1 ] || [ $columns_num -lt 1 ]   # error is defined in the script above
        then
            echo "Invalid"
            number_coulmns_entered=0
        else
            number_coulmns_entered=1
        fi
    done
    
    # Geiing columns types (string or int) and names
    typeset -i counter
    counter=1 # Not 0, 0 is reserved for the id column
    let columns_num=$columns_num+1
    
    while [ $counter -lt $columns_num ]
    do
        echo "Type of column $counter: "
        select choice in "string" "int"
        do
            case $choice in
                "string" ) 
                    types=$types:string
                break;;
                "int" )
                    types=$types:int
                break;;
                [~] )
                    exit 0
                ;;
                *)
                    echo "$REPLY is not one of the choices."
                ;;
        esac
        done
        column_name_entered=0
        while [ $column_name_entered == 0 ]
        do
            echo "Name of column $counter: "
            . utils/get_word.sh 
            if [ $? == 1 ]
            then
                echo "Invalid"
                continue
            fi
    
            # Getting the clean word
            column_name=$entered_word  # entered_word is defined in the above script
            
            names=$names:$column_name
            column_name_entered=1
        done
        counter=$counter+1
    done
    
    # Here, we have table fields names and types. Now we create the table (file)
    table_file=$root_dir/databases/$chosen_database/$table_name
    touch $table_file
    echo $columns_num > $table_file
    echo $types >> $table_file
    echo $names >> $table_file
    echo "$table_name created successfully!" 
  
    return 1  
}

create_table
