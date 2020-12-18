#! /bin/bash

. utils/header_script.sh

# Calling list database script to list avaialble databases
. database_scripts/list_database.sh 1

databases=$available_databases  # available_databases is defined in the script above

if [ $found_database == 0 ]   # found_database is defined in the script above
then
    echo "No databases to open!"
else
    # Getting available databases in array form
    typeset -i index
    index=0
    for db in $databases
    do
        database_array[$index]=$db
        index=$index+1
    done
    
    while true
    do
        # Reading user input
        echo "Eeter the number of the database to open: "
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
        if  (( number < ${#database_array[@]} && number > -1 ))
        then
            # Calling the script that handles opening a database
            db_to_open=${database_array[$number]}
            database_scripts/inside_database.sh $db_to_open   
            
            # User has returned to select another database, so we clear the screen then print it again
            clear
            echo "~  Go Back"
            echo ""
            . database_scripts/list_database.sh 1
        else
            echo "Invalid"
        fi
    done
fi
