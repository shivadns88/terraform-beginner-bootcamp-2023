# Terraform Beginner Bootcamp 2023 - Week 2

## Table of Content

- [Working with Ruby](#working-with-ruby)
  - [Bundler](#bundler)
  - [Install Gems](#install-gems)
  - [Executing ruby scripts in the context of bundler](#executing-ruby-scripts-in-the-context-of-bundler)
    - [Sinatra](#sinatra)
- [Terratowns Mock Server](#terratowns-mock-server)
  - [Running the web server](#running-the-web-server)
  -[CRUD](#crud)
- [Using Variable Block in Terraform](#using-variable-block-in-terraform)
- [Final Deployment of Terrahome to Terratown](#final-deployment-of-terrahome-to-terratown)

## Working with Ruby
[Ruby Language](https://www.ruby-lang.org/en/)
Ruby is an interpreted, high-level, general-purpose programming language which supports multiple programming paradigms.
Ruby is dynamically typed and uses garbage collection and just-in-time compilation. 
It supports multiple programming paradigms, including procedural, object-oriented, and functional programming
### Bundler
[Bundler Package Manager for Ruby](https://bundler.io/)
Bundler provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed. 
Bundler is an exit from dependency hell, and ensures that the gems you need are present in development, staging, and production. 
Starting work on a project is as simple as bundle install .

### Install Gems
[Ruby in Gem File](https://bundler.io/guides/gemfile.html)
We need to create a Gemfile and define the gems in that file.
Gemfiles require at least one gem source, in the form of the URL for a RubyGems server. 
Generate a Gemfile with the default rubygems.org source by running bundle init. 
If you can, use https so your connection to the rubygems.org server will be verified with SSL.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then we need to run the `bundle install` command.

This will install the gems on the system globally (unline nodejs which installs packages in place within a folder called node_modules)

A Gemfile.lock will be created to lock down the gem versions used in this project.

### Executing ruby scripts in the context of bundler

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed. This is the way we set context.

#### Sinatra

[Sinatra](https://sinatrarb.com/) is a micro web-framework for ruby to build web-apps.

It is great work for mock or dev servers for simple projects.

web-servers can be created from a single file.

## Terratowns Mock Server
Terratowns server can be run locally in the gitpod environment for testing purpose.
### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```
### CRUD
Ruby Sinatra is probably the second most popular web framework in the Ruby ecosystem, second to the behemoth of Ruby on Rails. 
Ruby is a more minimalist framework like Javascripts, Express or Pythons, Flask.

This can be used to create CRUD APIs

[CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete)
CRUD stands for Create, read, update and delete.

## Using Variable Block in Terraform

Each input variable accepted by a module must be declared using a variable block
For Example:

```tf
variable "mobilehome" {
type = object({
  public_path = string
  content_version = number
})
}
```
Following is declared in the `terraform.tfvars` file referencing to the variable block created in the variables.tf as shown above

```tf
mobilehome = {
    public_path = "/workspace/terraform-beginner-bootcamp-2023/public/mobilehome"
    content_version = 2
}
```
## Final Deployment of Terrahome to Terratown

- We created the Custom Terraform Provider
- We Created separate modules for different terrahomes we launch
- We created resources for these terrahomes
- We refactored the code to make sure different variables are used for each of these resources
- We finally made sure the terraform code is maintained in terraform cloud environment
- We deployed the terrahomes to the terratowns environment running [here](https://terratowns.cloud/)
- My Terratown is running [here](https://terratowns.cloud/t/the-nomad-pad) - You know which one it is!