#! /bin/bash

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
field=1

line_to_insert=$row_id

# Getting the data the user wants tp insert
while [ $counter -lt $number_of_columns ]
do
    field=$counter+1
    col_type=$(sed -n '2p' $table_path | cut -f$field -d:)
    col_name=$(sed -n '3p' $table_path | cut -f$field -d:)
    
    if [ $col_type == "int" ]
    then
        echo "$col_name[type:$col_type]: "
        . utils/get_number.sh
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
