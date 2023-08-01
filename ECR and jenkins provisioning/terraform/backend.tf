terraform {
  backend "remote" {
    organization = "narbyd"

    workspaces {
      name = "narbyd-terraform-cloud"
    }
  }
}

