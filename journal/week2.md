# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby

### Bundler

This is the package manager for ruby.
This is the primary way to install ruby packages (which are also known as gems) for ruby.

### Install Gems

We need to create a Gemfile and define the gems in that file.

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

### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```
