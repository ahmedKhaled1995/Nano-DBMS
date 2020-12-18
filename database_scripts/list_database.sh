#! /bin/bash

available_databases=$(ls $root_dir/databases)
found_database=0

# Checking if the available_databases string length is equal to zero
# if so, then no databases were created
if [ -z $available_databases ] 2> /dev/null
then
    echo "No databases created yet!"
else
    found_database=1
    echo "--------------------------"
    echo "# | database_name"
    echo "--------------------------"
    typeset -i i
    i=1
    for db in $available_databases
    do
        echo "$i | $db"
        i=$i+1
    done
fi
echo "--------------------------"
echo

# Cheching if this script was called with an argument or not
# if no arguments were passed, we wait for user to hit enter to end this script
if [ $# -eq 0 ]
then
    echo "Press enter to continue"
    read ans
fi
