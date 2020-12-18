#! /bin/bash

database_created=0

while [ $database_created == 0 ]
do
    echo "Enter database name: "
    
    # Calling the get_clean_word.sh script to get the clean database name
    . utils/get_word.sh 
    if [ $? == 1 ]
    then
        echo "Invalid"
        continue
    fi
    
    # Getting the clean word
    database_name=$entered_word  # entered_word is defined in the above script
    
    ls $root_dir/databases/$database_name > /dev/null 2> /dev/null

    if [ $? -eq 0 ]
    then
        echo "Database already exists! Please enter another name: " 
    else
        mkdir $root_dir/databases/$database_name
        echo "$database_name created successfully!" 
        database_created=1  # To break out of the while loop 
    fi
done

echo "Press enter to continue"
read ans
