# Terraform Beginner Bootcamp 2023 - Week 1

## Table of Content

- [Root Module Structure](#root-module-structure)
  - [Terraform Cloud Variables](#terraform-cloud-variables)
  - [Var Flag](#var-flag)
  - [Setting Variables using Var Definitions](#setting-variables-by-var-definitions)
  - [Terraform tfvars file](#terraform-tfvars-file)
  - [Auto TFVars Files](#auto-tfvars-files)
  - [Order of Terraform Variables](#order-of-terraform-variables)
  - [Restructure Root Module](#restructure-root-module)
- [Dealing with Configuration Drift](#dealing-with-configuration-drift)
- [What if we lose state file](#what-if-we-lose-state-file)
- [Fixing Code in Terraform](#fixing-code-in-terraform)
  - [Fix Missing Resources with Terraform import](#fix-missing-resources-with-terraform-import)
  - [Fix Manual Configuration](#fix-manual-configuration)
  - [Fix using Terraform Refresh](#fix-using-terraform-refresh)
- [Terraform Modules](#terraform-modules)
  - [Passing Input Variables](#passing-input-variables)
  - [Module Sources](#module-sources)
- [Considerations when using ChatGPT to write Terraform Code](#considerations-when-using-chatgpt-to-write-terraform-code)
- [Working with Files in Terraform](#working-with-files-in-terraform)
  - [File and File Exists Functions](#file-and-file-exists-functions)
  - [Path Variable](#path-variable)
  - [Filemd5 function](#filemd5-function)
- [Terraform Locals](#terraform-locals)
- [Terraform Data Sources](#terraform-data-sources)
  - [Working with JSON in Terraform using jsonencode](#working-with-json-in-terraform-using-jsonencode)
  - [Changing lifecycles of Resources](#changing-lifecycles-of-resources)
- [Terraform Data](#terraform-data)
- [Terraform Provisioners](#terraform-provisioners)
  - [Local Exec](#local-exec)
  - [Remote Exec](#remote-exec)
  - [For Each in Terraform](#for-each-in-terraform)
  - [Fileset](#fileset)
- [Terraform - Secret Management Challenges](#terraform---secret-management-challenges)
  - [Sensitive Data Source - Secure State Files](#sensitive-data-source---secure-state-files)
  - [Sensitive Data - Access to Sensitive Data in Terraform Cloud](#sensitive-data---access-to-sensitive-data-in-terraform-cloud)
  - [Secret Management using Cloud Native or Other Services](#secret-management-using-cloud-native-or-other-services)
  - [User Access to Secrets](#user-access-to-secrets)
  - [Secret Management - Variables in Terraform Cloud](#secret-management---variables-in-terraform-cloud)
    - [Outputs in Terraform can also be sensitive](#outputs-in-terraform-can-also-be-sensitive)

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

### Terraform Cloud Variables
In Terraform Cloud, we can set 2 kinds of variables:
- Environment Variables    - Those you would set in your bash terminal. Example AWS_ variables
- Terraform Variables      - Those you would normall set in terraform using tfvars file

We can set Terraform Cloud Variables to be sensitive so they are not shown visibily in the UI

### var Flag

We can use the `-var` flag to set an input variables or override a variable in the tfvars file.
Example: `terraform -var user_uuid="my-user-uuid"`

### Setting variables by var definitions
To set lots of variables, it is more convenient to specify their values in a variable definitions file (with a filename ending in either .tfvars or .tfvars.json) and then specify that file on the command line with -var-file:

```terraform
terraform apply -var-file="testing.tfvars"
```

### terraform tfvars file

This is the default file to load in terraform variables

### auto tfvars files
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

## Dealing with Configuration Drift
[Terraform Drift Detection](https://www.hashicorp.com/blog/detecting-and-managing-drift-with-terraform)

## What if we lose state file

If the state file is lost, we most likely will have to tear down all the cloud infrastructure manually.
We can use terraform port but it won't for all cloud resources. We need to check the terraform providers documentation for which resources support import.

## Fixing Code in Terraform

Sometimes, we need to perform changes to fix terraform code for various reasons
- fixing missing resources
- fixing manual configurations
- fixing using terraform refresh

### Fix Missing Resources with Terraform import
[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

`terraform import aws_s3_bucket.s3_bucket bucket-name`


### Fix Manual Configuration
If someone accidentally deletes or modifies resources manually through clickops, we can restore the infrastructure back in place using `terraform plan`

### Fix using Terraform Refresh

```sh
terraform apply --refresh-only --auto-approve
```

## Terraform Modules

[Terraform Modules](https://developer.hashicorp.com/terraform/language/modules)

### Passing Input Variables

We can pass input variables to our module
The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws"
 source = "./modules/terrahouse_aws"
 user_uuid = var.user_uuid
 bucket_name = var.bucket_name
```

### Module Sources

[Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

Using the source we can import module from various places.
Example:

- locally
- github
- terraform registry

```tf
module "terrahouse_aws {
  source = "./modules/terrahouse_aws"
}
```

## Considerations when using ChatGPT to write Terraform Code

LLMs such as ChatGPT may not be trained on the latest documentation or information about Terraform so it may likely produce older example that could be deprecated, often affecting terraform providers.

## Working with Files in Terraform
Various file functions can be used in terraform to handle file operations
### File and File Exists Functions

- variable "index_html_filepath" is declared with a type of string and a description to provide information about the variable.
- The validation block is used to enforce the condition that checks if the specified index_html_filepath exists and is a valid file path.
- file(var.index_html_filepath) checks if the file at the path specified by the variable exists.
- fileexists(var.index_html_filepath) verifies that the path specified by the variable is a valid file path.

Code for the variable index.html file path and to validate the variable:

```tf
variable "index_html_filepath" {
  type        = string
  description = "Path to the index.html file"

  validation {
    condition     = can(file(var.index_html_filepath)) && can(fileexists(var.index_html_filepath))
    error_message = "The specified index_html_filepath does not exist or is not a valid file path."
  }
}
```
Code for error.html file path and to validate the variable:

```tf
variable "error_html_filepath" {
  type        = string
  description = "Path to the error.html file"

  validation {
    condition     = can(file(var.error_html_filepath)) && can(fileexists(var.error_html_filepath))
    error_message = "The specified index_html_filepath does not exist or is not a valid file path."
  }
}
```

### Path Variable
In Terraform, there is a special variable called `path` that allows us to reference local paths:

- path.module = get the path for the current module
- path.root = get the path for the root module

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references)

Code for index.html s3 Object which references source path using the variable index_html_filepath defined previously

```tf
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  key    = "index.html"
  source = var.index_html_filepath
  etag = filemd5(var.index_html_filepath)
}
```

Code for error.html s3 Object which references source path using the variable error_html_filepath defined previously

```tf
resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  key    = "error.html"
  source = var.error_html_filepath
  etag = filemd5(var.error_html_filepath)
}
```

### Filemd5 function

[Filemd5 Function](https://developer.hashicorp.com/terraform/language/functions/filemd5)

filemd5 is a variant of `md5` that hashes the contents of a given file rather than a literal string.
This is similar to `md5(file(filename))`, but because file accepts only UTF-8 text it cannot be used to create hashes for binary files.

## Terraform Locals
[Terraform Locals](https://developer.hashicorp.com/terraform/language/values/locals)
This allows us to source data from cloud resources

```tf
locals {
  # Ids for multiple sets of EC2 instances, merged together
  instance_ids = concat(aws_instance.blue.*.id, aws_instance.green.*.id)
}
```

## Terraform Data Sources

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)
[Caller Identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)

A data source is accessed via a special kind of resource known as a data resource, declared using a data block:

### Working with JSON in Terraform using jsonencode

[JSONEncode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)
The JSON encoding maps Terraform language values to JSON values.
Example: 

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

### Changing lifecycles of Resources
[Meta Arguments Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

The Resource Behavior page describes the general lifecycle for resources. Some details of that behavior can be customized using the special nested lifecycle block within a resource block body:

```tf
resource "aws_s3_object" "s3_bucket" {
  # ...
  lifecycle {
    ignore_changes = [etag]
      # Ignore changes to tags
  }
}
```

## Terraform Data
[Terraform Data](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. 

You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

```tf
#declare the variable content_version
variable "content_version" {
  type        = number
  description = "The content version (positive integer starting at 1)"
}

#Create the resource content_version which gets input from the variable defined above
resource "terraform_data" "content_version" {
  input = var.content_version
} 

#reference/use content_version for terraform_data as shown below
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  key    = "index.html"
  source = var.index_html_filepath
  content_type = "text/html"

  etag = filemd5(var.index_html_filepath)

  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [etag]
      # Ignore changes to etags
  }
}
```
## Terraform Provisioners
[Terraform Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

Provisioners allow you to execute commands on compute instances and other resources.
For example, you can use AWS CLI commands.

These are not recommended for use by Hashicorp and it is recommended to use Config Mgmt tools such as Ansible, Chef for such use case.

### Local Exec

This will execute command on the machine running terraform commands 

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

### Remote Exec

This will execute commands on a machine which you target. You will need to provide credentials.

### For Each in Terraform
[For Each in Terraform](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)

The for_each meta-argument accepts a map or a set of strings, and creates an instance for each item in that map or set. 

Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.

```tf
resource "aws_s3_object" "upload_assets" {
  for_each = fileset("${path.root}/public/assets", "*.{jpg,png,gif}")
  bucket = aws_s3_bucket.s3_bucket.bucket
  key    = "assets/${each.key}"
  source = "${path.root}/public/assets/${each.key}"
  etag = filemd5("${path.root}/public/assets/${each.key}")
  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [etag]
      # Ignore changes to etags
  }
}
```

### Fileset 

fileset enumerates a set of regular file names given a path and pattern. 

The path is automatically removed from the resulting set of file names and any result still containing path separators always returns forward slash (/) as the path separator for cross-system compatibility.

Example:

```tf
$terraform console

> fileset("${path.root}/public/assets", "*.{jpg,png,gif}")
toset([
  "TerraDome.png",
  "Terracastle.png",
])

```

## Terraform - Secret Management Challenges

### Sensitive Data Source - Secure State Files

Following are security sensitive details in Terraform:

- Hard Coded Secrets in File
- State Files Information
- Variable Files
- Provider/Environment Variables

### Sensitive Data - Access to Sensitive Data in Terraform Cloud

- Run can be managed by specific users in cloud

### Secret Management using Cloud Native or Other Services

Following can be used for secret management

- AWS Secret Manager
- Azure Key Vault
- Google Secret Manager
- Hashicorp Vault

### User Access to Secrets

- Running can be managed by specific users in cloud
- Enable Granular access management

### Secret Management - Variables in Terraform Cloud

Variables in Terraform Cloud can be either

- HCL Variable
- Env Variable
  - Secrets - example: AWS Access Keys, Secret, etc.

#### Outputs in Terraform can also be sensitive
This is managed by adding a property `sensitive = "true"`

