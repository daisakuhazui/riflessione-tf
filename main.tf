provider "aws" {
  region  = "ap-northeast-1"
  version = "2.55.0"
}

provider "aws" {
  alias   = "virginia"
  region  = "us-east-1"
  version = "2.55.0"
}

provider "aws" {
  alias   = "oregon"
  region  = "us-west-2"
  version = "2.55.0"
}


terraform {
  required_version = ">= 0.12.9"

  backend "s3" {
    bucket = "riflessione-tfstate"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}
