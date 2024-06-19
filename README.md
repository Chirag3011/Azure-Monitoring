# Azure-Monitoring

# Azure CLI Scripts Repository

This repository contains a collection of Azure CLI scripts for maintaining and administering resources on the Azure cloud platform.

## Overview

Azure CLI (Command-Line Interface) is a powerful tool for managing Azure resources from the command line or in scripts. This repository serves as a central location for storing and sharing scripts that automate various tasks related to Azure resource management.

## Contents

- [Script 1](./get_resgrps.sh): This script will list and store all resource groups and their resources from the choice of subscription.
- [Script 2](./get_rmndiag.sh): This script will list and store all resource group's resources diagnostic settings details and also what settings resources have.
- [Script 3](./get_resid.sh): This script will list all resource group resource's resource id.
- [Script 4](./json.sh): This script will list resource ids from json file to be imported via terraform.
- [Script 5](./mv_acr_rep_new_acr.sh) This script will use a list of desired repo-name txt as named <acr_chk>

## Usage
./get_resgrps.sh
./get_rmndiag.sh
./get_resid.sh
./json.sh "<json_file_name>"
./mv_acr_rep_new_acr.sh <acr_chk>

1. Clone the repository to your local machine:

```bash
git clone https://github.com/Chirag3011/Azure-Monitoring.git
