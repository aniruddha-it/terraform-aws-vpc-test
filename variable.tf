variable "vpc_config" {
  description = "To get the cidr and name of VPC from user"
  type = object({
    cidr_block = string
    vpc_name = string
  })

  validation {
    condition = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "CIDR value is not in proper format - ${var.vpc_config.cidr_block}"
  }
}


 variable "sub_config" {
    description = "Get the data of CIDR and AZ for the subnets"
   type = map(object({
     cidr_block = string
     az = string
     public = optional(bool,false)
   }))

   validation {
    condition = alltrue([for config in var.sub_config: can(cidrnetmask(config.cidr_block))])
    error_message = "CIDR value is not in proper format"
  }
 }

