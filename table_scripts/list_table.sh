#! /bin/bash

available_tables=$(ls $root_dir/databases/$chosen_database)
found_table=0

# Checking if the available_tables string length is equal to zero
# if so, then no tables were created
if [ -z $available_tables ] 2> /dev/null
then
    echo "No tables created yet!"
else
    found_table=1
    echo "--------------------------"
    echo "# | table_name"
    echo "--------------------------"
    typeset -i i
    i=1
    for table in $available_tables
    do
        echo "$i | $table"
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
