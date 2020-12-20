#! /bin/bash

. utils/header_script.sh

number_of_columns=$(sed -n '1p' $table_path | cut -f1 -d:)

row_id=$(sed '$!d' $table_path | cut -f1 -d:)
expr $row_id + 0 > /dev/null 2> /dev/null 
id_found=$?

# Checking if there's data in the table
if [ $id_found != 0 ]
then
    echo "Can not delete! Empty table"
else
    typeset -i counter
    typeset -i field
    counter=0
    
    # Getting types and names of columns
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
    counter=0
    while [ $counter -lt $number_of_columns ]
    do
        field=$counter+1
        echo "$field) Delete by ${col_names_arr[$counter]}. "
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
        
        # Getting th clean input
        user_choice=$entered_number # entered_number is defined in the above script
        let user_choices_limit=$number_of_columns
        
        # Checking if user entered a valid number
        if [ $user_choice -lt 1 ] || [ $user_choice -gt $user_choices_limit ]   # error is defined in the script above
        then
            echo "Invalid"
            #user_made_a_choice=0
            continue
        else
            # Here, we want to check the type of the field the user wants to delete (int or string) to see
            # if we will get get_number script or get_word script
            value_entered=0
            let awk_user_choice=$user_choice
            let user_choice=$user_choice-1
            
            if [ ${col_types_arr[$user_choice]} == "int" ]
            # Getting the value if the int field to delete
            then
                while [ $value_entered == 0 ]
                do
                    echo "${col_names_arr[$user_choice]}[${col_types_arr[$user_choice]}] = "
                    . utils/get_number.sh
                    code=$?
                    
                    # Checking if user entered empty column to substitue it's value by null
                    if [ $is_null == 1 ] # is_null is defined in the above script
                    then
                        value="NULL"
                        value_entered=1
                        continue
                    fi
    
                    if [ $code == 1 ]
                    then
                        echo "Invalid"
                        continue
                    fi
        
                    # Getting the clean input
                    value=$entered_number # entered_number is defined in the above script
                    value_entered=1
                done
            else
                # Getting the value if the string field to delete
                while [ $value_entered == 0 ]
                do
                    echo "${col_names_arr[$user_choice]}[${col_types_arr[$user_choice]}] = "
                    . utils/get_word.sh 
                    
                    # Checking if use entered NULL
                    if [ -z $entered_word ]
                    code=$?
                    then
                        value="NULL"
                        value_entered=1
                        continue
                    fi
                    
                    if [ $code == 1 ]
                    then
                        echo "Invalid"
                        continue
                    fi
 
                    # Getting the clean word
                    value=$entered_word  # entered_word is defined in the above script
                    value_entered=1
                done
            fi
        fi
    user_made_a_choice=1
    rows_count_before_deletion=$(wc -l $table_path | cut -f1 -d' ') 
    awk -i inplace -F: "{if(NR == 1 || NR == 2 || NR == 3 ) {print \$0} else if(\$$awk_user_choice != \"$value\") {print \$0} }" $table_path 
    rows_count_after_deletion=$(wc -l $table_path | cut -f1 -d' ') 
    if [ $rows_count_before_deletion -gt $rows_count_after_deletion ]
    then
        echo "Record deleted Successfully!"
    else
        echo "Record does not exist!"
    fi
    done
    
fi
echo "Press any key to continue: "
read
