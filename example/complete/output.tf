output "vpc" {
  value = module.vpc.vpc-id
}

output "public-subnet-id" {
  value = module.vpc.public-subnet-id
}

output "private-subnet-id" {
  value = module.vpc.private-subnet-id
}