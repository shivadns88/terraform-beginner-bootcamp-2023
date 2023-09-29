# Terraform Beginner Bootcamp 2023 - Week 0

## Table of Content

## Root Module Structure

Our root module structure will have the following components:

```
PROJECT_ROOT
│
├── main.tf                  # everything else
├── variables.tf             # stores the structure of input variables
├── terraform.tfvars         # the data of variables we want to load to our terraform project
├── providers.tf             # defines required providers and their configuration
├── outputs.tf               # stores our outputs
└── README.md                # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
