#! /bin/bash

cleaned_number=''
error=0
code=0

# If 0 is returend, then user doesn't want to go back. 1 then means user wants to go back to previous menu
function get_clean_number
{
    read entered_num
    
    #echo ${#entered_num} 
    
    if [ ${#entered_num} == 0 ]
    then
        code=5  # To indicate user wants to input a null
    fi
  
    number_found=0
    for (( i=0; i<${#entered_num}; i++ ));
    do  
        case ${entered_num:$i:1} in
            [0-9] )   
            cleaned_number=$cleaned_number${entered_num:$i:1}
            number_found=1
            ;;
            [-] )   
            cleaned_number=$cleaned_number${entered_num:$i:1}
            if [ $i != 0 ]
            then
               error=1
            fi 
            ;;
            [~] )
            code=1
            ;;
            * )
            error=1
        esac  
    done
    
    if [ $number_found == 0 ]
    then
        error=1
    fi 
    
    if [ $error == 0 ]
    then
        # Getting rid of any trailling zeros
        cleaned_number=$(expr $cleaned_number + 0)
    fi
    
    return $code
}

get_clean_number
