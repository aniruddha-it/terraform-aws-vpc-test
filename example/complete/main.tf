provider "aws" {
  region = "eu-north-1"
}

module "vpc" {
  source = "./module/vpc"
  
  vpc_config = { 
    cidr_block = "10.0.0.0/16"
    vpc_name = "my-vpc"
  }

sub_config = {
    public-subnet-1 = {
        cidr_block = "10.0.0.0/24"
        az = "eu-north-1a"
        public = true
    }
    public-subnet-2 = {
        cidr_block = "10.0.3.0/24"
        az = "eu-north-1a"
        public = true
    }

    private-subnet = {
        cidr_block = "10.0.1.0/24"
        az = "eu-north-1b"
    }
  }
}

