#! /bin/bash

# Creating the main path of the program
export root_dir="$HOME/My_Nano_mysql"

# Will check the return code of the command, if 0 then file Folder exists and 
# needs not to be created again
ls $root_dir > /dev/null 2> /dev/null

if [ $? -eq 0 ]
then
    echo "Found" > /dev/null
else
    echo "Not found" > /dev/null
    mkdir $root_dir
    mkdir $root_dir/databases
fi
