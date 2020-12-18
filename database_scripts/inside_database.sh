#! /bin/bash

export chosen_database=$1
#path_to_chosen_database=$root_dir/databases/$chosen_database

while true
do
    clear

    echo ">>>$chosen_database"
    echo ""

    select choice in "Create table." "Delete table." "Open table." "List all tables." "Back."
    do
        case $choice in
            "Create table." ) 
                clear
                table_scripts/create_table.sh
            break;;
            "Delete table." )
                clear
                table_scripts/delete_table.sh
            break;;
            "Open table." )
                clear
                table_scripts/open_table.sh
            break;;
            "List all tables." )
                clear
                table_scripts/list_table.sh
            break;;
            "Back." )
                exit 0
            ;;
            * )
                echo "$REPLY is not one of the choices."
            ;;
        esac
    done
done
