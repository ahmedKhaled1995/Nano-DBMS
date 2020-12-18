#! /bin/bash

export chosen_table=$1
export table_path=$root_dir/databases/$chosen_database/$chosen_table

while true
do
    clear

    echo ">>>$chosen_database>>$chosen_table"
    echo ""

    select choice in "Insert record." "Delete record." "Update record." "List all records." "Back."
    do
        case $choice in
            "Insert record." ) 
                clear
                record_scripts/create_record.sh
            break;;
            "Delete record." )
                clear
                record_scripts/delete_record.sh
            break;;
            "Update record." )
                clear
                record_scripts/update_record.sh
            break;;
            "List all records." )
                clear
                record_scripts/list_records.sh
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
