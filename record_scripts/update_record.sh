#! /bin/bash

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
    counter=1
    while [ $counter -lt $number_of_columns ]
    do
        echo "$counter) Update ${col_names_arr[$counter]}. "
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
        user_choice=$entered_number # entered_number is defined in the above script
        let user_choices_limit=$number_of_columns-1
        
        # Checking if user entered a valid number
        if [ $user_choice -lt 1 ] || [ $user_choice -gt $user_choices_limit ]   # error is defined in the script above
        then
            echo "Invalid"
            continue
        else
            # Here, we want to check the type of the field the user wants to update (int or string) to see
            # if we will get get_number script or get_word script
            value_entered=0
            let awk_user_choice=$user_choice+1
            let user_choice=$user_choice
            
            if [ ${col_types_arr[$user_choice]} == "int" ]
            then
                # Getting the value of the int column to update
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
                    value=$entered_number # entered_number is defined in the above script
                    value_entered=1
                done
                
                # Getting the value of the new int column
                value_entered=0
                while [ $value_entered == 0 ]
                do
                    echo "New ${col_names_arr[$user_choice]}[${col_types_arr[$user_choice]}] = "
                    . utils/get_number.sh
                    if [ $? == 1 ]
                    then
                        echo "Invalid"
                        continue
                    fi
        
                    # Getting the clean input
                    new_value=$entered_number # entered_number is defined in the above script
                    value_entered=1
                done
                
            else
                # Getting the value if the string col to update
                while [ $value_entered == 0 ]
                do
                    echo "${col_names_arr[$user_choice]}[${col_types_arr[$user_choice]}] = "
                    . utils/get_word.sh 
                    if [ $? == 1 ]
                    then
                        echo "Invalid"
                        continue
                    fi
 
                    # Getting the clean word
                    value=$entered_word  # entered_word is defined in the above script
                    value_entered=1
                done
                
                # Getting the value if the new string column
                value_entered=0
                while [ $value_entered == 0 ]
                do
                    echo "New ${col_names_arr[$user_choice]}[${col_types_arr[$user_choice]}] = "
                    . utils/get_word.sh 
                    if [ $? == 1 ]
                    then
                        echo "Invalid"
                        continue
                    fi
 
                    # Getting the clean word
                    new_value=$entered_word  # entered_word is defined in the above script
                    value_entered=1
                done
            fi
        fi
    
    awk -i inplace -F: "
        BEGIN { OFS=FS }
        {
            if(NR == 1) {
                print \$0}   
            else if(\$$awk_user_choice == \"$value\") {
               \$$awk_user_choice=\"$new_value\";
               print \$0;
            }
            else {
                print \$0} 
        }" $table_path 
        
    echo "Operation complete"
    
    user_made_a_choice=1
    done
    
fi
echo "Press any key to continue: "
read
