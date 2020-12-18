#! /bin/bash

number_of_columns=$(sed -n '1p' $table_path | cut -f1 -d:)

row_id=$(sed '$!d' $table_path | cut -f1 -d:)
expr $row_id + 0 > /dev/null 2> /dev/null 
id_found=$?
if [ $id_found != 0 ]
then
    echo "Empty table"
else
    # Printing the table header
    typeset -i counter
    typeset -i field
    counter=0
    
    header=""
    line1=""
    line2=""
    
    while [ $counter -lt $number_of_columns ]
    do
        header=$header"-------"
        field=$counter+1
        col_type=$(sed -n '2p' $table_path | cut -f$field -d:)
        col_name=$(sed -n '3p' $table_path | cut -f$field -d:)
        line1="$line1$col_name   | "   
        line2="$line2$col_type|"  
        counter=$counter+1
    done
    
    echo $header
    echo $line1
    echo $line2
    echo $header
    
    # Now, we print the table body
    typeset -i line
    line=3
    number_of_rows=$(wc -l $table_path | cut -f1 -d' ')
    while [ $line -lt $number_of_rows ]
    do
        line=$line+1
        counter=0
        field=0
        record=""
        while [ $counter -lt $number_of_columns ]
        do
            field=$counter+1
            value=$(sed -n "$line p" $table_path | cut -f$field -d:)
            record="$record$value| "
            counter=$counter+1
        done
        echo "$record"
    done
    echo "$header"
fi

echo "Press any key to continue: "
read
