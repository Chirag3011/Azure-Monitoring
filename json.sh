#!/bin/bash

file=$1

usage() {

        if [ "$#" -eq 0 ]; then
                echo "please provide a json file name"
                echo " "
                echo "EXAMPLE:- "
                echo "./script.sh  <filename>"
                exit 1;
        fi
}


import_nsg() {
        awk '/"defaultSecurityRules"/,/^end$/{next} 1' ${file} > file1.txt
        grep -e "name" -e "id" file1.txt > ids1.txt
        sed -r 's/:/=/g' ids1.txt > ids.txt
        sed -i  '/id/a \\' ids.txt
        sed 's/"\([^"]*\)"=/\1=/g' ids.txt > import_id.txt
        rm ids.txt ids1.txt file1.txt
}


locals_nsg() {
        awk '/"defaultSecurityRules"/,/^end$/{next} 1' ${file} > file1.txt
        grep -e "name" -e "priority" -e "direction" -e "access" -e "protocol" -e "sourcePortRange" -e "destinationPortRange" -e "sourceAddressPrefix" -e "destinationAddressPrefix" file1.txt > file.txt
        sed -r 's/:/=/g' file.txt > output.txt
        sed -i  '/destinationAddressPrefixes/a \\' output.txt
        sed 's/"\([^"]*\)"=/\1=/g' output.txt > json_coverted.txt
        rm file1.txt file.txt output.txt
}


usage
import_nsg
locals_nsg
