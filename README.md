# Terraform & ServiceNow Demo


## Requirements

- [Terraform](https://www.terraform.io/downloads.html)

## Setup

- Install Terraform if you don't already have it
  * You can use [Homebrew](https://brew.sh/) `brew install terraform`
- Make a copy of the example .envrc file: `cp .envrc.example .envrc`
- Edit the `.envrc` file to have the correct AWS credentials for the AWS provider you will use
- Load the variables in the shell: `source ./envrc`

You should now be able to use the example AWS provider configurations

## Usage

```
terraform init
terraform plan

terraform apply
```

