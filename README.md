# Terraform Beginner Bootcamp 2023

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

### Working with Environment Variabls

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

