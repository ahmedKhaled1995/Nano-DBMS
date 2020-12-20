#! /bin/bash

entered_word=""

function get_word
{
    . utils/get_clean_word.sh

    # Checking if user wants to return to previous menu
    code=$?
    if [ $code == 1 ]
    then
        exit 0
    fi

    # Getting the clean input
    entered_word=$cleaned_word   # cleaned_word is defined in the above script
    
    # Checking if user entered a valid word
    if [ -z $entered_word ] || [ $entered_word == "int" ] || [ $entered_word == "string" ]  || [ $entered_word == "id" ]  || [ $entered_word == "NULL" ]
    then
        return 1
    else
        return 0
    fi
}

get_word
