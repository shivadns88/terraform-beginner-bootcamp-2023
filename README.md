# Terraform Beginner Bootcamp 2023

## weekly journals

- [week 0 journal](journal/week0.md)
- [week 1 journal](journal/week1.md)

## extras
- [GitHub Markdown TOC Generator](https://ecotrust-canada.github.io/markdown-toc/)

### Terraform Cloud Variables
In Terraform Cloud, we can set 2 kinds of variables:
- Environment Variables    - Those you would set in your bash terminal. Example AWS_ variables
- Terraform Variables      - Those you would normall set in terraform using tfvars file

We can set Terraform Cloud Variables to be sensitive so they are not shown visibily in the UI

### var Flag

We can use the `-var` flag to set an input variables or override a variable in the tfvars file.
Example: `terraform -var user_uuid="my-user-uuid"`

### 
To set lots of variables, it is more convenient to specify their values in a variable definitions file (with a filename ending in either .tfvars or .tfvars.json) and then specify that file on the command line with -var-file:

```terraform
terraform apply -var-file="testing.tfvars"
```

### terraform.tfvars

This is the default file to load in terraform variables

### auto.tfvars
Terraform also automatically loads a number of variable definitions files if they are present:
- Files named exactly terraform.tfvars or terraform.tfvars.json.
- Any files with names ending in .auto.tfvars or .auto.tfvars.json.

### Order of terraform variables
Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

- Environment variables
- The terraform.tfvars file, if present.
- The terraform.tfvars.json file, if present.
- Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
- Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### Restructure Root Module

- To Restructure Root Module, we added outputs.tf, providers.tf, terraform.tfvars, variables.tf
- We also modified gitpod.yml to make sure the terraform.tfvars file gets generated when the environment is loaded:
 - This is done by following steps:
   - creating another file terraform.tfvars.example
   - Copying adding a line in gitpod.yml file to copy terraform.tfvars.example to terraform.tfvars by below command:
     ```sh
     $PROJECT_ROOT/terraform.tfvars.example $PROJECT_ROOT/terraform.tfvars
     ```