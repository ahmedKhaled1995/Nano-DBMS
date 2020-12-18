#! /bin/bash

# Calling list_database.sh script to display the avaiable databases
# also, note how I pass 1 as an argument to list_database.sh because in the script if a an argument is passed (regardless of its value),
# that means that we just want to list the available the databases without prompting the user to press any key to go back the main
# program view (database view).

# Also Note how we specify the database_scripts folder even though this script and list_database.sh are in the same directory,
# the reason for that is because this script is called by source from the main.sh script, which is located in the main
# project directory (inside the project directory is the database_scripts directory).

. database_scripts/list_database.sh 1

databases=$available_databases  # available_databases is defined in the script above

if [ $found_database == 0 ]   # found_database is defined in the script above
then
    echo "Can not delete!"
else
    # Getting available databases in array form
    typeset -i index
    index=0
    for db in $databases
    do
        database_array[$index]=$db
        index=$index+1
    done
    
    database_deleted=0
    while [ $database_deleted == 0 ]
    do
        # Reading user input
        echo "Eeter the number of the database to delete: "
        . utils/get_number.sh
        if [ $? == 1 ]
        then
            echo "Invalid"
            continue
        fi
        
        # Getting th clean input
        number=$entered_number # entered_number is defined in the above script
        
        # Deleting the specified database
        let number=$number-1
        if  (( number < ${#database_array[@]} && number > -1 )) 
        then
            db_to_delete=${database_array[$number]}
            rm -r $root_dir/databases/$db_to_delete
            echo "${database_array[$number]} deleted successfully!"
            database_deleted=1
        else
            echo "Invalid"
        fi
    done
fi

echo "Press enter to continue"
read ans
