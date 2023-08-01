terraform {
  backend "remote" {
    organization = "narbyd"

    workspaces {
      name = "tooling-terraform-cloud"
    }
  }
}

