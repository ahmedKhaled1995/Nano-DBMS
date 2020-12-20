#! /bin/bash

. utils/header_script.sh "Hit enter to escape input a field, NULL will be added."

number_of_columns=$(sed -n '1p' $table_path | cut -f1 -d:)

# Getting the id of the last inserted. if expr fails it means
# we tried to convert a non int value, which means no rows are inserted yet, so we set id to 0 
row_id=$(sed '$!d' $table_path | cut -f1 -d:)
expr $row_id + 0 > /dev/null 2> /dev/null 
id_found=$?
if [ $id_found != 0 ]
then
    row_id=1
else
    let row_id=$row_id+1
fi

typeset -i counter
typeset -i field
counter=1

# Displaying column names
field=2
line=" | "
while [ $field -le $number_of_columns ]
do
    col_type=$(sed -n '2p' $table_path | cut -f$field -d:)
    col_name=$(sed -n '3p' $table_path | cut -f$field -d:)
    line="$line$col_name[$col_type]  |  "
    field=$field+1
done
echo "Table Columns: $line"
echo ""

# Getting columns to add to database
line_to_insert=$row_id
field=1
while [ $counter -lt $number_of_columns ]
do
    field=$counter+1
    col_type=$(sed -n '2p' $table_path | cut -f$field -d:)
    col_name=$(sed -n '3p' $table_path | cut -f$field -d:)
    
    if [ $col_type == "int" ]
    then
        echo "$col_name[type:$col_type]: "
        . utils/get_number.sh
        
        # Checking if user entered empty column to substitue it's value by null
        if [ -z $entered_number ] # entered_number is defined in the above script
        then
            value="NULL"
            line_to_insert=$line_to_insert:$value
            counter=$counter+1
            continue
        fi
        
        if [ $? == 1 ]
        then
            echo "Invalid"
            continue
        fi
        
        # Getting th clean input
        value=$entered_number # entered_number is defined in the above script
        line_to_insert=$line_to_insert:$value
    else
        echo "$col_name[type:$col_type]: "
       . utils/get_word.sh 
       
        # Checking if user entered empty column to substitue it's value by null
        if [ -z $entered_word ] # entered_word is defined in the above script
        then
            value="NULL"
            line_to_insert=$line_to_insert:$value
            counter=$counter+1
            continue
        fi
       
        if [ $? == 1 ]
        then
            echo "Invalid"
            continue
        fi
    
        # Getting the clean word
        value=$entered_word  # entered_word is defined in the above script
        line_to_insert=$line_to_insert:$value
    fi
    counter=$counter+1
done

# Writing the entered line to the file (Adding row to the table)
echo $line_to_insert >> $table_path
echo "Record added successfully!"

echo "Press Enter to continue: "
read
