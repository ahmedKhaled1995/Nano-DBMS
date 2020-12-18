#! /bin/bash

#-------------------------------------------------------------#
# This script is heart of the program (Like main method in C) #
#-------------------------------------------------------------#

# Calling the init script to iniatlize the program main directory in user's home directry if the program's main directory doesn't exist
. init.sh

while true
do
    # Clearing the terminal from any previous data
    clear
    
    # Opening database view scipt
    database_scripts/database_view.sh

    # User's choise from database view
    user_choise=$?

    if [ $user_choise == 1 ]
    then
        # Clearing the terminal and displaying create database
        clear
        database_scripts/create_database.sh
    elif [ $user_choise == 2 ]
    then
        # Clearing the terminal and displaying open database
        clear
        database_scripts/open_database.sh
    elif [ $user_choise == 3 ]
    then
        # Clearing the terminal and displaying delete database
        clear
        database_scripts/delete_database.sh
    elif [ $user_choise == 4 ]
    then
        # Clearing the terminal and displaying list database
        clear
        database_scripts/list_database.sh
    elif [ $user_choise == 5 ]
    then
        # Clearing the terminal and exiting the program
        clear
        exit 0
    fi
done
