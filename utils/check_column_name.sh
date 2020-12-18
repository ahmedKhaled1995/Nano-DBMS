#! /bin/bash

# This script is used as a helper script to enuser all column names 
# of a table are uniqu

name_found=0

function check_column_name
{
    
    local index=0
    
    while [ $index -lt ${#column_names_arr[@]} ]
    do
        if [ ${column_names_arr[$index]} == $column_name ]
        then
            name_found=1
            break
        fi
        let index=$index+1
    done
    
    return $name_found
    
}

check_column_name
