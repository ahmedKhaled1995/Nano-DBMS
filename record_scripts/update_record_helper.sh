#! /bin/bash

# This script is used as a helper script to update record
# All that script does is get the the value of the column to update and the new column value

value_entered=0

# Getting the value of the int column to update
if [ ${col_types_arr[$user_choice]} == "int" ]
then
while [ $value_entered == 0 ]
do
    # If we are updating by id we want to escape that loop, since I already know the raw id and the field the user wants to update
    # to do so, we simply call this script with an argument. Here I check if the script was called with an argumrnt
    # and if so, I escape that loop to go straight to the new value
    if [ $# -gt 0 ]
    then
        break
    fi
    
    
    echo "Current ${col_names_arr[$user_choice]}[${col_types_arr[$user_choice]}] = "
    . utils/get_number.sh
    code=$?
    
    # Checking if use entered NULL
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

# Getting the value of the new int column
value_entered=0
while [ $value_entered == 0 ]
do
    echo "New ${col_names_arr[$user_choice]}[${col_types_arr[$user_choice]}] = "
    . utils/get_number.sh
    code=$?
    
    # Checking if user entered empty column to substitue it's value by null
    if [ $is_null == 1 ] # is_null is defined in the above script
    then
        new_value="NULL"
        value_entered=1
        continue
    fi
    
    if [ $code == 1 ]
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
    # If we are updating by id we want to escape that loop, since I already know the raw id and the field the user wants to update
    # to do so, we simply call this script with an argument. Here I check if the script was called with an argumrnt
    # and if so, I escape that loop to go straight to the new value
    if [ $# -gt 0 ]
    then
        break
    fi
    
    echo "Current ${col_names_arr[$user_choice]}[${col_types_arr[$user_choice]}] = "
    . utils/get_word.sh 
    code=$?
    
    # Checking if use entered NULL
    if [ -z $entered_word ]
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

# Getting the value if the new string column
value_entered=0
while [ $value_entered == 0 ]
do
    echo "New ${col_names_arr[$user_choice]}[${col_types_arr[$user_choice]}] = "
    . utils/get_word.sh
    code=$?
    
    # Checking if user entered empty column to substitue it's value by null
    if [ -z $entered_word ] # entered_word is defined in the above script
    then
        new_value="NULL"
        value_entered=1
        continue
    fi
     
    if [ $code == 1 ]
    then
        echo "Invalid"
        continue
    fi

    # Getting the clean word
    new_value=$entered_word  # entered_word is defined in the above script
    value_entered=1
done
fi
