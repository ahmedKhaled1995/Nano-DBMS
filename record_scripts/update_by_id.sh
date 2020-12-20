#! /bin/bash

# This script is used for updating only the id column

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
        # Getting the column to update and the new values
        . record_scripts/update_record_helper.sh 1
    fi

    # Updating the file (database)
    let awk_user_choice=$user_choice+1 # Because id is the first field
    
    # VIP: Since I store metadata in the table file in the first 3 files, I have to increase the row_id by 3
    let row_id=$row_id+3
    
    awk -i inplace -F: "
    BEGIN { OFS=FS }
    {
        if(NR == 1 || NR == 2 || NR == 3) {
            print \$0}   
        else if(NR == $row_id ) {
           \$$awk_user_choice=\"$new_value\";
           print \$0;
        }
        else {
            print \$0} 
    }" $table_path 

    echo "Operation complete"

    user_made_a_choice=1
done

echo "Press Enter to continue: "
read
