output "vpc_id" {
 value = module.networking.vpc_id
}

output "subnet_id" {
value =  module.networking.subnet_id
}

output "public_ip_for_ssh" {
value =  module.instance.instance_detail   
}