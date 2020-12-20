#! /bin/bash

. utils/header_script.sh "If empyt field is entered, NULL will be added as a value."

number_of_columns=$(sed -n '1p' $table_path | cut -f1 -d:)

row_id=$(sed '$!d' $table_path | cut -f1 -d:)
expr $row_id + 0 > /dev/null 2> /dev/null 
id_found=$?

# Checking if there's data in the table
if [ $id_found != 0 ]
then
    echo "Can not update! Empty table"
else
    typeset -i counter
    typeset -i field
    counter=0
    
    # Getting types and names of columns from the file (table)
    while [ $counter -lt $number_of_columns ]
    do
        field=$counter+1
        col_type=$(sed -n '2p' $table_path | cut -f$field -d:)
        col_name=$(sed -n '3p' $table_path | cut -f$field -d:)
        col_types_arr[$counter]=$col_type
        col_names_arr[$counter]=$col_name  
        counter=$counter+1
    done
    
    # Displaying options for the user
    typeset -i tmp
    counter=0
    while [ $counter -lt $number_of_columns ]
    do
        tmp=$counter+1;
        echo "$tmp) Update ${col_names_arr[$counter]}. "
        counter=$counter+1
    done
    
    # Getting user choice
    user_made_a_choice=0
    while [ $user_made_a_choice == 0 ]
    do
        # Getting user's choice
        echo "Your answer: "
        . utils/get_number.sh
        if [ $? == 1 ]
        then
            echo "Invalid"
            continue
        fi
        
        # Getting the clean input
        let user_choice=$entered_number-1 # entered_number is defined in the above script
        let user_choices_limit=$number_of_columns-1
        
        # Checking if user entered a valid number
        if [ $user_choice -lt 0 ] || [ $user_choice -gt $user_choices_limit ]   # error is defined in the script above
        then
            echo "Invalid"
            continue
        else
            # We check if the user wants to update id field, in such case
            # we call script made specially for updating by id
            if [ $user_choice == 0 ]
            then
                # Getting the value (id) of the int column to update
                value_entered=0
                while [ $value_entered == 0 ]
                do
                    echo "${col_names_arr[$user_choice]}[${col_types_arr[$user_choice]}] = "
                    . utils/get_number.sh
                    if [ $? == 1 ]
                    then
                        echo "Invalid"
                        continue
                    fi
            
                    # Getting the clean input
                    row_id=$entered_number # entered_number is defined in the above script
                    value_entered=1
                done
                
                . record_scripts/update_by_id.sh
                exit 0 
            fi
            
            # Here we are udating any column other than id so we
            # get the column to update and the new values
            # for that, we call a helper script
            . record_scripts/update_record_helper.sh
        fi
    
    # Updating the file (database)
    # info_before_update=$(stat -c %y $table_path | cut -f2 -d' ' )
    let awk_user_choice=$user_choice+1 # Because id is the first field
    awk -i inplace -F: "
        BEGIN { OFS=FS }
        {
            if(NR == 1 || NR == 2 || NR == 3) {
                print \$0}   
            else if(\$$awk_user_choice == \"$value\") {
               \$$awk_user_choice=\"$new_value\";
               print \$0;
            }
            else {
                print \$0} 
        }" $table_path 
    echo "Update operation completed!"
    user_made_a_choice=1
    done
    
fi
echo "Press Enter to continue: "
read
