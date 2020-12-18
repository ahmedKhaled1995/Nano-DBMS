#! /bin/bash

# This function displays the options avaialbe for the user
# When it finishes, it returnes the user's option as an exit code
function display_options
{
    user_choice=0
    select choice in "Create database." "Open database." "Delete database." "List all databases." "Exit."
    do
        case $choice in
            "Create database." ) 
                user_choice=1
            break;;
            "Open database." )
                user_choice=2
            break;;
            "Delete database." )
                user_choice=3
            break;;
            "List all databases." )
                user_choice=4
            break;;
            "Exit." )
                user_choice=5
            break;;
            *)
                echo "$REPLY is not one of the choices."
            ;;
    esac
    done
    return $user_choice
}

# Calling the above function
display_options
