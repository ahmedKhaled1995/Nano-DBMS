#! /bin/bash

. utils/header_script.sh

. table_scripts/list_table.sh 1

tables=$available_tables  # available_tables is defined in the script above

if [ $found_table == 0 ]   # found_table is defined in the script above
then
    echo "Can not delete!"
else
    # Getting available databases in array form
    typeset -i index
    index=0
    for table in $tables
    do
        table_array[$index]=$table
        index=$index+1
    done
    
    table_deleted=0
    while [ $table_deleted == 0 ]
    do
        # Reading user input
        echo "Eeter the number of the table to delete: "
        . utils/get_number.sh
        if [ $? == 1 ]
        then
            echo "Invalid"
            continue
        fi
        
        # Getting th clean input
        number=$entered_number # entered_number is defined in the above script
        
        # Deleting the specified table
        let number=$number-1
        if  (( number < ${#table_array[@]} && number > -1  ))
        then
            table_to_delete=${table_array[$number]}
            rm $root_dir/databases/$chosen_database/$table_to_delete
            echo "${table_array[$number]} deleted successfully!"
            table_deleted=1
        else
            echo "Invalid"
        fi
    done
fi

echo "Press enter to continue"
read ans
