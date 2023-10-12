#!/bin/bash

#################################################################################
# Script Name: 
# Author: Chirag Sharma
# Date: October 12, 2023
# Description:  This script will list and store all resource groups and their 
#               resources's ID from the choice of subscription.
# version:      1.02
##################################################################################


login() {
        echo " "
        az login
        if [ $? != 0 ];then echo "Please login via 'az login' then run this script.."; exit 1; fi

        echo " "
        az account list -o table
        echo " "; read -p "Please enter one subscription to run operation on: " subs

        az account set --subscription "${subs}"
        echo " "
        echo "Your current subscription set to: !0!---"; az account show -o table
}

resourceGroup() {
        echo " "
        az group list --query "[].{resource:name}" -o table | sed '1d' | sed '1d' > resourceGroup.txt
}

echo ".............PLEASE WAIT SCRIPT IS RUNNING..............."
echo " "
resources() {
        mkdir -p $(pwd)/resources
        while read -r line;
        do
                az resource list --resource-group ${line} --query "[].{name:name, resource:type}" -o table > $(pwd)/resources/${line}_resources.txt
        done < resourceGroup.txt
}

getID() {
	mkdir -p $(pwd)/resources/resourcegroup_resID
	res=$(ls resources/ | cut -d"." -f1)
	resgroup=$(cat resourceGroup.txt)

	for rg in ${resgroup};
	do
		file=$(echo "${rg}_resources.txt")
		while read -r line;
		do
			resname=$(echo ${line} | awk '{print $1}')
			restype=$(echo ${line} | awk '{print $2}')
			echo "$rg ---> $resname ---> $restype"
			az resource show --name "${resname}" --resource-group "${rg}" --resource-type "${restype}" --query id --output tsv
			echo " "
		done < $(pwd)/resources/${file} | tee $(pwd)/resources/resourcegroup_resID/${rg}_ids.txt
	done 
}

resourceGroup
resources
getID
