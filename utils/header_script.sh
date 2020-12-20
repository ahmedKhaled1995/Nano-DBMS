#! /bin/bash

# This script is used to display avaiable buttons to the user
# Will be used whenever we ask user for input

echo "#############################################################################"
echo "1) Type ~ (Tilda) then hit enter to go back to the previous menu."
echo "2) Reserved words:  int  -  string  -  id   -   NULL"
echo "3) Allowed chars are alphanumeric and under score ' a->z  A->Z  0->9  _ ' ."
echo "4) If an illegal char was input, it will be ignored and the input word will be taken without it."

# We check if we want to print any additional thing inside that block when calling the script
if [ $# -gt 0 ]
then
    typeset -i num
    num=5
    for arg in "$@"
    do
        echo "$num) $arg"
        num=$num+1
    done
fi
echo "#############################################################################"

echo ""
