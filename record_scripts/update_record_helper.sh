#! /bin/bash

# This script is used as a helper script to update record
# All that script does is get the the value of the column to update and the new column value

value_entered=0

if [ ${col_types_arr[$user_choice]} == "int" ]
then
# Getting the value of the int column to update
while [ $value_entered == 0 ]
do
    echo "Current ${col_names_arr[$user_choice]}[${col_types_arr[$user_choice]}] = "
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
    
    # Checking if user entered empty column to substitue it's value by null
    if [ -z $entered_number ] # entered_number is defined in the above script
    then
        new_value=NULL
        value_entered=1
        continue
    fi
    
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
    echo "Current ${col_names_arr[$user_choice]}[${col_types_arr[$user_choice]}] = "
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
    
    # Checking if user entered empty column to substitue it's value by null
    if [ -z $entered_word ] # entered_word is defined in the above script
    then
        new_value=NULL
        value_entered=1
        continue
    fi
     
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
