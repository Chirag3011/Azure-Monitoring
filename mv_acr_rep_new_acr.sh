#!/bin/bash

my_acr_name="<new_acr_name>"
source_acr_name="<old_acr_name>"

while read -r LINE;
do

        #check if image exist in curret acr.
        az acr repository list -n ${my_acr_name} | grep -s ${LINE} > /dev/null 2>&1
        if [ $? != 1 ]; then
                echo "Repository ${LINE} already exists...moving to next repo import"
        else
                echo "Repository ${LINE} doesn't exist and importing now..."
                echo " "
                images=$(az acr repository show-tags --name ${source_acr_name} --repository ${LINE} | tr -d '",[]')
                for image in ${images};
                do
                        az acr import --name ${my_acr_name} --source ${LINE}:${image} --image ${LINE}:${image} --registry "/subscriptions/69dc43ec-5f24-4203-xxxx-a8d0xxxx06d44/resourceGroups/resource_group/providers/Microsoft.ContainerRegistry/registries/registry_name"
                        if [ $? != 1 ]; then
                                echo "...${LINE}:${image} has been imported..."
                        else
                                echo "...Failed to import images..."
                                exit 1;
                        fi
                done
        fi
done < acr_imgchk
