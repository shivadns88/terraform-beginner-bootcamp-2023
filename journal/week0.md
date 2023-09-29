# Terraform Beginner Bootcamp 2023 - Week 0

## Table of Content

- [Semantic Versioning](#semantic-versioning-mage-cloud)
- [Install the Terraform CLI](#install-the-terraform-cli)
  - [Consideration for Linux Distribution](#consideration-for-linux-distribution)
  - [Shebang Considerations](#shebang-considerations)
  - [Bash Script Execution Considerations](#bash-script-execution-considerations)
  - [Refactoring into bash scripts](#refactoring-into-bash-scripts)
  - [Gitpod workspace tasks](#gitpod-workspace-tasks)
  - [Working with Environment Variables](#working-with-environment-variables)
    - [env command](#env-command)
    - [setting and unsetting env vars](#setting-and-unsetting-env-vars)
    - [Printing Vars](#printing-vars)
    - [Scoping of env vars](#scoping-of-env-vars)
    - [Persisting Env vars in Gitpod](#persisting-env-vars-in-gitpod)
  - [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)
  - [Terraform Registry](#terraform-registry)
  - [Terraform Providers](#terraform-providers)
  - [Terraform Modules](#terraform-modules)
  - [Terraform Console](#terraform-console)
    - [Terraform init](#terraform-init)
    - [Terraform Plan](#terraform-plan)
    - [Terraform Apply](#terraform-apply)
    - [Terraform Destroy](#terraform-destroy)
    - [Terraform lock files](#terraform-lock-files)
    - [Terraform state files](#terraform-state-files)
    - [Terraform Directory](#terraform-directory)
  - [Creating an S3 bucket in Terraform](#creating-an-s3-bucket-in-terraform)
    - [S3 bucket naming convention](#s3-bucket-naming-convention)
  - [Terraform Cloud](#terraform-cloud)
    - [Moving to Terraform Cloud](#moving-to-terraform-cloud)
    - [Error Required token could not be found](#error-required-token-could-not-be-found)
    - [Issues with Terraform Cloud Login and Gitpod workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)



## Semantic Versioning :mage: :cloud:

This project will utilize semantic versioning for the tagging.
[semver.org](https://semver.org/)

Given a version number **MAJOR.MINOR.PATCH**, increment the:

**MAJOR** version when you make incompatible API changes
**MINOR** version when you add functionality in a backward compatible manner
**PATCH** version when you make backward compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Install the Terraform CLI
The Terraform CLI installation instructions have changed due to gpg keyring changes so the original gitpod.yml needed to be modified.
This is now added as a bash script. 

### Consideration for Linux Distribution

This project is built against Ubuntu. 
Please consider checking your Linux Distribution and change accordingly to your distribution needs.

[Linux Command Line](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

### Shebang Considerations

A Shebang (pronounced Sha-bang) tells the bash script what program that will interpret the script. Example: '#! /bin/bash'
ChatGPT recommended we use the format '#! /usr/bin/env bash'
 - For portability with different OS distribution
 - Will search the user's PATH for the bash executable
[Linux Shebang](https://linuxize.com/post/bash-shebang/)

### Bash Script Execution Considerations

When executing the bash script we can use the `./` shorthand notation to execute the bash script.
Example: 

```sh
./bin/install_terraform_cli
```

If we are using a script in .gitpod.yml we need to point the script to a program to interpret it.
Example: 

```sh
source ./bin/install_terraform_cli
```

In order to make our bash scripts executable, we need to change linux permissions using chmod command.
Example: 

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively, we can use 

```sh
chmod 744 ./bin/install_terraform_cli
```

### Refactoring into bash scripts

While fixing the Terraform CLI gpg deprication issues, we noticed that the script steps were a considerable amount of code so we decided to create a bash script to install the terraform CLI.

This bash script is located at: [./bin.install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod task file neat and tidy
- This allows for an easier debug and execution of the terraform CLI manually later if needed
- This will allow better portability for other projects that need to install Terraform CLI

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Gitpod workspace tasks

- Since we are re-launching the existing workspace in Gitpod, we need terraform to be installed automatically using the script we created. To make sure the execution happens in an existing environment, we modify the gitpod.yml file
- We need to be careful when using init because gitpod will not rerun if we rstart an existing workspace.
[Gitpod workspace tasks](https://www.gitpod.io/docs/configure/workspaces/tasks)

### Working with Environment Variables

#### env command
We can list out all environment variables (env vars) using the `env` command
We can filter specific env vars using `env | grep AWS_`

#### setting and unsetting env vars
In the terminal, we can set env vars using `export HELLO='world'`

In the terminal, we can unset env vars using `unset HELLO`

We can set env var temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```

Within a bash script, we can set env without writing export. 
Example

```sh
#!/usr/bin/env bash

HELLO='world'
echo $HELLO
```

#### Printing Vars

We can print an env var using echo. Example `echo $HELLO`

#### Scoping of env vars

When we open new bash terminals in VSCode, it will not be aware of env vars set in another terminal window.
If we need env var to persist across all future terminals that are open, we need to set env vars in the bash profile

Example: `.bash_profile`

#### Persisting Env vars in Gitpod

We can persist Env Vars in Gitpod by storing them in Gitpod Secrets.

```sh
gp env HELLO='World'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

We can also set the env vars in the `.gitpod.yml` but this only for non sensitive vars

### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

In Cloud Developer Environment, we need to set up Env Vars for AWS CLI

We can check if our AWS Credentials are configured correcty by running the following AWS CLI Command:

```sh
aws sts get-caller-identity
```

If it is successful, we should see a JSON payload that looks like this:

```json
{
    "UserId": "ASDFGHJKLKEXAMPLEAWS",
    "Account": "XXXXXXXXXXXX",
    "Arn": "arn:aws:iam::XXXXXXXXXXXX:user/zzzshizzzzz"
}
```

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html#envvars-set)

## Terraform Basics


### Terraform Registry

Terraform sources their providers and modules from the terraform registry.
[Terraform Registry](https://registry.terraform.io/)


### Terraform Providers

- **Terraform provider** is a logical abstraction of an API. 
- They are responsible for understanding API interaction
[Terraform Providers](https://registry.terraform.io/browse/providers)


### Terraform Modules

- **Terraform Modules** are like templates
- Modules are self-contained packages of terraform configurations that are managed as a group
- Modules are a way to make large amount of terraform code modular, portable and sharable

### Terraform Console

We can see a list of all Terraform commands by typing `terraform`

- #### Terraform init

At the start of a new terraform project, we will run `terraform init` to download the binaries for the terraform providers that we will use in this project.

- #### Terraform Plan

This will generate out a changeset about the state of our infrastructure and what will be changed

We can output this changeset to be passed to an apply, but often you can just ignore outputting.

- #### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be executed by terraform. Apply should promot yes or no.
We can skip approving using `terraform apply --auto-approve`

- #### Terraform Destroy

The `Terraform Destroy` command will destroy the resources which were created by running `terraform apply`

- #### Terraform lock files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The terraform lock file should be committed to your version control system (VSC) example GitHub

- #### Terraform state files

`.terraform.tfstate` contain information about the current state of your infrastructure.

This file **should not be committed** to your VCS.
This file contains sensitive data.
If you lose this file, you lose knowing the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file.

### Terraform Directory

`.terraform` directory contains binaries of terraform providers.

### Creating an S3 bucket in Terraform

We need to refer to the below URLs regarding creation of S3 bucket in Terraform:

- [Terraform AWS S3 bucket provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
- [Terraform Random String Provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)

Following needs to be addressed regarding creation of S3 bucket.

- #### S3 bucket naming convention
  - S3 bucket naming convention does not allow upper case letters. [AWS S3 bucket naming rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html)
  - For this, we will need to modify the way random string is generated

### Terraform Cloud

 - #### Moving to Terraform Cloud

 - #### Error Required token could not be found

```
Initializing Terraform Cloud...
╷
│ Error: Required token could not be found
│ 
│ Run the following command to generate a token for app.terraform.io:
│     terraform login
```

 - #### Issues with Terraform Cloud Login and Gitpod workspace

When we attempt running `terraform login` it launches bash a wiswig view to generate a token, however this does not work as expected for us to copy paste the token.
The workaround is to create the below file manually.

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
```

```sh
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the below lines of code in the json file opened and use the code generated by the token.

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "<Terraform_Token_Generated_for_the_duration"
    }
  }
}
```

We have automated the process of generating the tfrc credentials and placing the file within the directory using bash script.
[bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)