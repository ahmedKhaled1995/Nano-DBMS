#! /bin/bash

echo "~  Go Back"
echo ""

# Calling list tables script to list avaialble tables
. table_scripts/list_table.sh 1

tables=$available_tables  # available_tables is defined in the script above

if [ $found_table == 0 ]   # found_table is defined in the script above
then
    echo "No tables to open!"
else
    # Getting available tables in array form
    typeset -i index
    index=0
    for table in $tables
    do
        table_array[$index]=$table
        index=$index+1
    done
    
    while true
    do
        # Reading user input
        echo "Eeter the number of the table to open: "
        . utils/get_number.sh
        if [ $? == 1 ]
        then
            echo "Invalid"
            continue
        fi
        
        # Getting th clean input
        number=$entered_number # entered_number is defined in the above script
        
        # Opening the specified database
        let number=$number-1
        if  (( number < ${#table_array[@]} && number > -1 ))
        then
            # Calling the script that handles opening a table
            table_to_open=${table_array[$number]}
            table_scripts/inside_table.sh $table_to_open 
            
            # User has returned to select another database, so we clear the screen then print it again
            clear
            echo "~  Go Back"
            echo ""
            . table_scripts/list_table.sh 1
        else
            echo "Invalid"
        fi
    done
fi

echo "Press enter to continue"
read ans
