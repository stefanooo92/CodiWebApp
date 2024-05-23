# CodiWebApp

This repository contains a simple web application hosted on Azure using Azure Container Apps.

## Test the app:
https://golf13.cloud


## Architecture
![alt text](https://github.com/stefanooo92/CodiWebApp/blob/main/diagrams/webapp_architecture.png?raw=true)


## How to Run
- Clone this repository
- Navigate to the project directory
- Replace "domain_name" variable in variable.tf file with your domain address
- Run Terraform scripts

```
# Initialize a working directory containing Terraform configuration files
$ terraform init

# Create an execution plan.
$ terraform plan

# Apply the changes required to reach the desired state of the configuration
$ terraform apply
```
- Delegate your domain to Azure Dns Zone you created


