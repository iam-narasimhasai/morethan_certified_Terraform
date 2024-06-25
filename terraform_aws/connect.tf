terraform {
  cloud {
    organization = "Terraform_stuff"

    workspaces {
      name = "Dev"
    }
  }
}
