#! /bin/bash

cleaned_word=''
code=0

# If 0 is returend, then user doesn't want to go back. 1 then means user wants to go back to previous menu
function get_clean_word
{
    read word
    
    for (( i=0; i<${#word}; i++ ));
    do  
        case ${word:$i:1} in
            [a-zA-Z0-9_] )  
            # Concatenating. As if we had written cleaned_word = $cleaned_word$ + {word:$i:1}
            # of couse we can't use spaces nor can we use the plus sign  
            cleaned_word=$cleaned_word${word:$i:1} 
            ;;
            [~] )
            code=1
        esac  
    done
    return $code
}

get_clean_word 
