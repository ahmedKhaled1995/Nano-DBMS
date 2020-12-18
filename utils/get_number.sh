#! /bin/bash

entered_number=""

function get_number
{
    . utils/get_clean_number.sh
        
        # Checking if user wants to return to previous menu
            code=$?
            if [ $code == 1 ]
            then
                exit 0
            fi
        
        # Getting th clean input
        entered_number=$cleaned_number # cleaned_word is defined in the above script
        
        # Checking if user entered valid number
        if [ $error == 1 ]   # error is defined in the script above
        then
            return 1
        else
            return 0
        fi
}

get_number
