#! /bin/bash

. utils/header_script.sh "VIP: Primary Key is genetrated automatically in a cloumn called 'id'. So don't enter a column for Primary Key."

# Getting table name
table_created=0

while [ $table_created == 0 ]
do
    # Calling the get_clean_word.sh script to get the clean database name
    echo "Enter table name: "
    . utils/get_word.sh 
    if [ $? == 1 ]
    then
        echo "Invalid"
        continue
    fi
    
    # Getting the clean table name
    table_name=$entered_word  # entered_word is defined in the above script
    
    ls $root_dir/databases/$chosen_database/$table_name > /dev/null 2> /dev/null

    if [ $? -eq 0 ]
    then
        echo "Table already exists! Please enter another name: " 
    else
    
        # call script that creates feilds (cloumns) and the table
        # call the script and pass table's name as argument
    	table_scripts/create_table_helper.sh $table_name
        table_created=$? # To break out of the while loop 
    fi
done

echo "Press enter to continue"
read ans
