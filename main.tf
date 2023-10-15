terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }

# Following lines of code will be used to migrate the terraform state to terraform cloud
  cloud {
    organization = "shivadns88_tech"

    workspaces {
      name = "terra-house-one"
    }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid 
  token = var.terratowns_access_token
}

#https://developer.hashicorp.com/terraform/language/modules/sources
# below code is for the dreamhome terrahome module
module "home_dream_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.dreamhome.public_path
  content_version = var.dreamhome.content_version
}

# below is for the dreamhome terrahome resource
resource "terratowns_home" "home_dream" {
  name = "shivaDNS building a home online!!!"
  description = <<DESCRIPTION
Building a home in Canada is not easy.
It is crazy expensive!
I am broke, so building a home online.
DESCRIPTION
  domain_name = module.home_dream_hosting.domain_name
  town = "missingo"
  content_version = var.dreamhome.content_version
}


# below is the code for the mobilehome terrahome module
module "home_mobile_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.mobilehome.public_path
  content_version = var.mobilehome.content_version
}

# below is the code for the mobilehome terrahome resource

resource "terratowns_home" "home_mobile" {
  name = "shivaDNS building a mobile home online!!!"
  description = <<DESCRIPTION
Mobile homes are great for travel and living anywhere!
I can convert a big vans into a mobile home!
I cannot build one in real life so building a mobile home online :-)
Check these mobile homes!
DESCRIPTION
  domain_name = module.home_mobile_hosting.domain_name
  town = "the-nomad-pad"
  content_version = var.mobilehome.content_version
}